import 'package:ms_outlook_calender/data/model/calendar_response.dart';
import 'package:ms_outlook_calender/data/model/calendar_view_response.dart';
import 'package:ms_outlook_calender/data/model/schedule_response.dart';
import 'package:ms_outlook_calender/data/model/token_response.dart';

abstract class OutlookRepository {

  Future<bool> authenticated();

  Future<EventResponse> fetchEvents(String startDateTime, String endDateTime);

  Future<ScheduleResponse> fetchSchedule(String startDateTime, String endDateTime);

  Future<CalendarResponse> fetchCalendar();

  Future<TokenResponse> fetchNewToken();
}