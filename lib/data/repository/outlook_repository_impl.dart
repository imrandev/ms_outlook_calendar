import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/core/log/logger.dart';
import 'package:ms_outlook_calender/core/network/api_client.dart';
import 'package:ms_outlook_calender/core/session/session_manager.dart';
import 'package:ms_outlook_calender/core/utils/constant.dart';
import 'package:ms_outlook_calender/core/utils/date_format_util.dart';
import 'package:ms_outlook_calender/core/utils/endpoints.dart';
import 'package:ms_outlook_calender/core/utils/message.dart';
import 'package:ms_outlook_calender/data/model/calendar_view_response.dart';
import 'package:ms_outlook_calender/data/model/schedule_response.dart';
import 'package:ms_outlook_calender/data/model/token_response.dart';
import 'package:ms_outlook_calender/domain/repository/outlook_repository.dart';
import 'package:oauth2_client/oauth2_client.dart';

@Injectable(as: OutlookRepository)
class OutlookRepositoryImpl implements OutlookRepository {

  final SessionManager _sessionManager;

  final ApiClient _apiClient;

  OutlookRepositoryImpl(this._sessionManager, this._apiClient);

  @override
  Future<bool> authenticated() async {
    var client = OAuth2Client(
      authorizeUrl: 'https://login.microsoftonline.com/${Constant.tenantId}/oauth2/v2.0/authorize',
      tokenUrl: 'https://login.microsoftonline.com/${Constant.tenantId}/oauth2/v2.0/token',
      redirectUri: Constant.redirectUrl,
      customUriScheme: Constant.customScheme,
    );
    
    var token = await client.getTokenWithAuthCodeFlow(
      clientId: Constant.clientId,
      scopes: ['openid profile offline_access calendars.read'],
    );
    print('accessToken: ${token.accessToken}');
    bool hasToken = token.accessToken!= null && token.accessToken!.isNotEmpty;
    if (hasToken){
      _sessionManager.accessToken = "Bearer ${token.respMap['access_token']}";
      _sessionManager.refreshToken = "${token.respMap['refresh_token']}";
      _sessionManager.idToken = "${token.respMap['id_token']}";
      _sessionManager.tokenExpiration = token.respMap['expiration_date'];
    }
    return hasToken;
  }

  @override
  Future<CalendarViewResponse> fetchCalendarView(String startDateTime, String endDateTime) async {

    // if token expired
    DateTime? expirationDate = _sessionManager.tokenExpiration != null
        ? DateFormatUtil.toDateTime(_sessionManager.tokenExpiration!) : null;

    if (expirationDate != null && DateTime.now().isAfter(expirationDate)){
      await fetchNewToken();
    }

    try {
      dynamic data = await _apiClient.getWithHeader(
        EndPoints.calendarView,
        baseUrl: Constant.baseUrl,
        params: {
          "startDateTime" : startDateTime,
          "endDateTime" : endDateTime,
        },
      ).onError((error, stackTrace) {
        return CalendarViewResponse(
          isSuccess: false,
          message: error is DioError ? error.message : Message.connectionFailed,
        );
      });

      if (data == null){
        return CalendarViewResponse(
          isSuccess: false,
          message: Message.connectionFailed,
        );
      }
      CalendarViewResponse response = CalendarViewResponse.fromJson(data);
      if (response.value == null) {
        return CalendarViewResponse(
          isSuccess: false,
          message: Message.noRecordFound,
        );
      }
      return response;
    } on Exception catch (_, e){
      logger.e(e.toString());
      return CalendarViewResponse(
        message: e.toString(),
        isSuccess: false,
      );
    }
  }

  @override
  Future<ScheduleResponse> fetchSchedule(String startDateTime, String endDateTime) async {
    try {

      // if token expired
      DateTime? expirationDate = _sessionManager.tokenExpiration != null
          ? DateFormatUtil.toDateTime(_sessionManager.tokenExpiration!) : null;
      if (expirationDate != null && DateTime.now().isAfter(expirationDate)){
        await fetchNewToken();
      }

      dynamic data = await _apiClient.postWithDataAndHeader(
        EndPoints.getSchedule,
        baseUrl: Constant.baseUrl,
        data: {
          "schedules": ["qm1@sqgc.com"],
          "startTime": {
            "dateTime": startDateTime,
            "timeZone": "Asia/Dhaka"
          },
          "endTime": {
            "dateTime": endDateTime,
            "timeZone": "Asia/Dhaka"
          },
          "availabilityViewInterval": 30
        },
        header: {
          "Authorization" : _sessionManager.accessToken!,
          "Content-Type": 'application/json',
          "Prefer": 'outlook.timezone="Asia/Dhaka"',
        },
      ).onError((error, stackTrace) {
        return ScheduleResponse(
          isSuccess: false,
          message: error is DioError ? error.message : Message.connectionFailed,
        );
      });

      if (data == null){
        return ScheduleResponse(
          isSuccess: false,
          message: Message.connectionFailed,
        );
      }

      ScheduleResponse response = ScheduleResponse.fromJson(json.decode(data.toString()));
      if (response.value == null) {
        return ScheduleResponse(
          isSuccess: false,
          message: Message.noRecordFound,
        );
      }

      if (response.value!.isNotEmpty && (response.value![0].scheduleItems == null || response.value![0].scheduleItems!.isEmpty)){
        return ScheduleResponse(
          isSuccess: false,
          message: Message.noMeetingFound,
        );
      }

      return response;
    } on Exception catch (_, e){
      logger.e(e.toString());
      return ScheduleResponse(
        message: e.toString(),
        isSuccess: false,
      );
    }
  }

  @override
  Future<TokenResponse> fetchNewToken() async {
    try {
      dynamic data = await _apiClient.postWithData(
        EndPoints.token,
        options: Options(
          contentType: "application/x-www-form-urlencoded",
        ),
        baseUrl: "https://login.microsoftonline.com",
        data: {
          "client_id" : Constant.clientId,
          "refresh_token": _sessionManager.refreshToken!,
          "grant_type": "refresh_token",
        },
      ).onError((error, stackTrace) {
        logger.e(error.toString());
        return TokenResponse(
          isSuccess: false,
          message: error is DioError ? error.message : Message.connectionFailed,
        );
      });

      if (data == null){
        return TokenResponse(
          isSuccess: false,
          message: Message.connectionFailed,
        );
      }

      TokenResponse response = TokenResponse.fromJson(json.decode(data.toString()));
      _sessionManager.accessToken = response.accessToken!;
      _sessionManager.refreshToken = response.refreshToken!;
      _sessionManager.tokenExpiration = DateTime.now().add(Duration(seconds: response.expiresIn!,)).millisecondsSinceEpoch;
      return response;
    } on Exception catch (_, e){
      logger.e(e.toString());
      return TokenResponse(
        message: e.toString(),
        isSuccess: false,
      );
    }
  }
}