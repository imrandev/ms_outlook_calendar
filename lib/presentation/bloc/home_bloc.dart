import 'package:ms_outlook_calender/core/bloc/bloc.dart';
import 'package:ms_outlook_calender/core/di/injection.dart';
import 'package:ms_outlook_calender/core/session/session_manager.dart';
import 'package:ms_outlook_calender/core/utils/date_format_util.dart';
import 'package:ms_outlook_calender/data/model/calendar_view_response.dart';
import 'package:ms_outlook_calender/data/model/schedule_response.dart';
import 'package:ms_outlook_calender/domain/usecase/authenticate_usecase.dart';
import 'package:ms_outlook_calender/domain/usecase/get_calendar_view_usecase.dart';
import 'package:ms_outlook_calender/domain/usecase/get_schedule_usecase.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {

  final AuthenticateUseCase _authenticateUseCase = getIt<AuthenticateUseCase>();

  final GetCalendarViewUseCase _calendarViewUseCase = getIt<GetCalendarViewUseCase>();

  final GetScheduleUseCase _scheduleUseCase = getIt<GetScheduleUseCase>();

  final SessionManager _sessionManager = getIt<SessionManager>();

  final _calendarController = BehaviorSubject<EventResponse>();
  Function(EventResponse response) get _calendarSink => _calendarController.sink.add;
  Stream<EventResponse> get calendarStream => _calendarController.stream;

  final _scheduleController = BehaviorSubject<ScheduleResponse>();
  Function(ScheduleResponse response) get _scheduleSink => _scheduleController.sink.add;
  Stream<ScheduleResponse> get scheduleStream => _scheduleController.stream;

  @override
  void dispose() {
    _calendarController.close();
    _scheduleController.close();
  }

  @override
  void init(Function(String p1) showMessage) async {
    fetch();
  }

  Future<void> fetch() async {
    // if access refresh token is not available
    // we have to start the authenticate process from the scratch
    if (_sessionManager.refreshToken == null){
      await _authenticateUseCase.invoke();
    }

    // call get schedule api for meeting room
    DateTime dateTime = DateTime.now();
    String startDateTime = DateFormatUtil.getCurrentDateTime(dateTime);
    String endDateTime = DateFormatUtil.getAdding30MinToCurrentDateTime(dateTime);
    //ScheduleResponse response = await _scheduleUseCase.invoke(startDateTime, endDateTime);
    EventResponse response = await _calendarViewUseCase.invoke(startDateTime, endDateTime);
    _calendarSink(response);
  }
}