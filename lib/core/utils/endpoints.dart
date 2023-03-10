import 'package:ms_outlook_calender/core/utils/constant.dart';

class EndPoints {
  static const calendarView = "/v1.0/me/calendar/calendarView";
  static const getSchedule = "/v1.0/me/calendar/getSchedule";
  static const calendar = "/v1.0/me/calendar";
  static const event = "/v1.0/me/events";
  static const token = "/${Constant.tenantId}/oauth2/v2.0/token";
}