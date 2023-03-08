import 'package:injectable/injectable.dart';
import 'package:ms_outlook_calender/data/model/schedule_response.dart';
import 'package:ms_outlook_calender/domain/repository/outlook_repository.dart';

@injectable
class GetScheduleUseCase {

  final OutlookRepository _repository;

  GetScheduleUseCase(this._repository);

  Future<ScheduleResponse> invoke (String startDateTime,String endDateTime) {
    return _repository.fetchSchedule(startDateTime, endDateTime);
  }
}