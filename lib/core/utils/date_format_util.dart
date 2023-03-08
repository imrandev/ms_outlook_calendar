import 'package:intl/intl.dart';

class DateFormatUtil {

  static DateFormat currentTimeFormat = DateFormat("hh:mm aa");

  static DateFormat currentDateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  static DateFormat currentDateTimeUTCFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");

  static DateFormat currentDateTimeUTCZFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.Z");

  static DateFormat currentDateFormat = DateFormat("MMMM dd, yyyy");

  static String getCurrentDate(){
    return currentDateFormat.format(DateTime.parse(currentDateFormat.parse(currentDateFormat.format(DateTime.now()), true).toUtc().toString()));
  }

  static String getCurrentDateTime(DateTime now){
    return currentDateTimeUTCFormat.format(DateTime.parse(currentDateTimeUTCFormat.parse(currentDateTimeUTCFormat.format(now), true).toUtc().toString()));
  }

  static String getAdding30MinToCurrentDateTime(DateTime now){
    return currentDateTimeUTCFormat.format(DateTime.parse(currentDateTimeUTCFormat.parse(currentDateTimeUTCFormat.format(now.add(const Duration(minutes: 30))), true).toUtc().toString()));
  }

  static String getCurrentTime(){
    return currentTimeFormat.format(DateTime.parse(currentTimeFormat.parse(currentTimeFormat.format(DateTime.now()), true).toUtc().toString()));
  }

  static DateTime toDateTime(int date){
    return DateTime.fromMillisecondsSinceEpoch(date);
  }

  static String formattedDateTimeAsString(String dateTime){
    return currentTimeFormat.format(currentDateTimeUTCZFormat.parse(dateTime));
  }

  static DateTime formattedDateTime(String dateTime){
    return currentDateTimeUTCZFormat.parse(dateTime);
  }
}