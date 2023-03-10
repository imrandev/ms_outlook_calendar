import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/core/utils/date_format_util.dart';
import 'package:ms_outlook_calender/data/model/calendar_view_response.dart';
import 'package:ms_outlook_calender/domain/repository/outlook_repository.dart';

@injectable
class GetCalendarViewUseCase {

  final OutlookRepository _repository;

  GetCalendarViewUseCase(this._repository);

  Future<EventResponse> invoke(String startDateTime, String endDateTime) async {
    EventResponse response = await _repository.fetchEvents(startDateTime, endDateTime);
    if (response.value != null && response.value!.isNotEmpty){
      // sort list by start date time
      var eventList = response.value!.where((element) => DateTime.now().isBefore(DateFormatUtil.formattedDateTime(element.end!.dateTime!))).toList();
      eventList.sort((a, b) {
        var s1 = DateFormatUtil.formattedDateTime(a.start!.dateTime!);
        var s2 = DateFormatUtil.formattedDateTime(b.start!.dateTime!);
        return s1.compareTo(s2);
      });
      response.value = eventList;
    }
    return response;
  }
}