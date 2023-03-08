import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/data/model/calendar_view_response.dart';
import 'package:ms_outlook_calender/domain/repository/outlook_repository.dart';

@injectable
class GetCalendarViewUseCase {

  final OutlookRepository _repository;

  GetCalendarViewUseCase(this._repository);

  Future<CalendarViewResponse> invoke(String startDateTime, String endDateTime){
    return _repository.fetchCalendarView(startDateTime, endDateTime);
  }
}