import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:ms_outlook_calender/core/bloc/bloc.dart';
import 'package:ms_outlook_calender/core/utils/constant.dart';
import 'package:ms_outlook_calender/core/utils/date_format_util.dart';
import 'package:ms_outlook_calender/core/utils/message.dart';
import 'package:ms_outlook_calender/data/model/calendar_view_response.dart';
import 'package:ms_outlook_calender/presentation/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomeBloc bloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      body: StreamBuilder(
        builder: (context, _) => StreamBuilder<EventResponse>(
          builder: (context, snapshot) => Container(
            color: _getMainBackground(snapshot.data),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //top view
                _getTopAppbar(snapshot.data),
                // center view
                _getMeetingView(snapshot.data, bloc),
                // bottom view
                _getBottomView(context, snapshot.data),
              ],
            ),
          ),
          stream: bloc.calendarStream,
        ),
        stream: Stream.periodic(const Duration(minutes: 10)).asyncMap((event) => bloc.fetch()),
      ),
    );
  }

  Color _getMainBackground(EventResponse? response){

    if (response == null || response.availabilityView == null){
      return const Color(0xff7AB19F);
    }
    if (response.availabilityView! == Constant.occupied){
      return const Color(0xffC24447);
    }
    if (response.availabilityView! == Constant.tentative){
      return const Color(0xffC24447);
    }
    if (response.availabilityView! == Constant.available){
      return const Color(0xff7AB19F);
    }
    if (response.availabilityView! == Constant.outOfOffice){
      return const Color(0xff7AB19F);
    }
    if (response.availabilityView! == Constant.workingElseWhere){
      return const Color(0xffC24447);
    }
    return const Color(0xff7AB19F);
  }

  Color _getWidgetBackground(EventResponse? response){

    if (response == null || response.availabilityView == null){
      return const Color(0xff71A491);
    }
    if (response.availabilityView! == Constant.occupied){
      return const Color(0xffCB494B);
    }
    if (response.availabilityView! == Constant.tentative){
      return const Color(0xffCB494B);
    }
    if (response.availabilityView! == Constant.available){
      return const Color(0xff71A491);
    }
    if (response.availabilityView! == Constant.outOfOffice){
      return const Color(0xff71A491);
    }
    if (response.availabilityView! == Constant.workingElseWhere){
      return const Color(0xffCB494B);
    }
    return const Color(0xff71A491);
  }

  Widget _getTopAppbar(EventResponse? response){
    return AppBar(
      elevation: 0,
      backgroundColor: _getWidgetBackground(response),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_getLocation(response), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18,),),
          const SizedBox(height: 5,),
          Text(
            _getAvailabilityStatus(response),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14,),
          ),
        ],
      ),
    );
  }

  String _getLocation(EventResponse? response){
    if (response != null && response.owner != null){
      return response.owner!.toUpperCase();
    }
    return "";
  }

  String _getAvailabilityStatus(EventResponse? response){
    if (response == null || response.availabilityView == null){
      return "";
    }
    if (response.availabilityView! == Constant.occupied){
      return "Occupied";
    }
    if (response.availabilityView! == Constant.tentative){
      return "Occupied";
    }
    if (response.availabilityView! == Constant.available){
      return "Available";
    }
    if (response.availabilityView! == Constant.outOfOffice){
      return "Available";
    }
    if (response.availabilityView! == Constant.workingElseWhere){
      return "Occupied";
    }
    return "";
  }

  Widget _getBottomView(BuildContext context, EventResponse? response){
    return Container(
      height: MediaQuery.of(context).size.height / 16,
      color: _getWidgetBackground(response),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(left: 8,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    builder: (context, snapshot) => Text(
                      DateFormatUtil.getCurrentTime(),
                      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300,),
                    ),
                    stream: Stream.periodic(const Duration(seconds: 1,),),
                  ),
                  Text(
                    DateFormatUtil.getCurrentDate(),
                    style: const TextStyle(color: Colors.white, fontSize: 10,),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.gamepad, color: Colors.white,),
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 8,),
                  child: Text("Q", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold,),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMeetingView(EventResponse? response, HomeBloc bloc){
    if (response == null){
      return const Expanded(
        flex: 1,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (response.message != null && response.message!.isNotEmpty){
      return Expanded(
        flex: 1,
        child: Center(
          child: Text(response.message!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300,), textAlign: TextAlign.center,),
        ),
      );
    }
    if (response.value == null || response.value!.isEmpty){
      return const Expanded(
        flex: 1,
        child: Center(
          child: Text(Message.noMeetingFound, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18,), textAlign: TextAlign.center,),
        ),
      );
    }
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getRemainingTimeView(response, bloc),
            const SizedBox(height: 8,),
            Text(response.value![0].organizer!.emailAddress!.name!, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300,),),
            const SizedBox(height: 8,),
            Text(response.value![0].subject!, style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w400,),),
            const SizedBox(height: 8,),
            Text(_getMeetingTime(response), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300,),),
            const SizedBox(height: 16,),
            _getNextScheduleView(response),
          ],
        ),
      ),
    );
  }

  Widget _getRemainingTimeView(EventResponse response, HomeBloc bloc){
    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [10],
      color: Colors.white,
      strokeWidth: 1,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: StreamBuilder(
          builder: (context, s) {
            bool hasMeetingStarted = DateTime.now().isAfter(DateFormatUtil
                .formattedDateTime(response.value![0].start!.dateTime!));
            int durationInMinutes = 0;
            if (hasMeetingStarted) {
              durationInMinutes = DateFormatUtil
                  .formattedDateTime(response.value![0].end!.dateTime!)
                  .difference(DateTime.now())
                  .inMinutes;
              int durationInSeconds = DateFormatUtil
                  .formattedDateTime(response.value![0].end!.dateTime!)
                  .difference(DateTime.now())
                  .inSeconds;
              if (durationInMinutes == 0 && durationInSeconds == 1) {
                bloc.fetch();
              }
              if (durationInMinutes < 0){
                durationInMinutes = 0;
              }
            }
            return Text(
              "$durationInMinutes",
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold,),
            );
          },
          stream: Stream.periodic(const Duration(seconds: 1,)),
        ),
      ),
    );
  }

  String _getMeetingTime(EventResponse response){
    String startDateTime = DateFormatUtil.formattedDateTimeAsString(response.value![0].start!.dateTime!);
    String endDateTime = DateFormatUtil.formattedDateTimeAsString(response.value![0].end!.dateTime!);
    return "$startDateTime - $endDateTime";
  }

  Widget _getNextScheduleView(EventResponse response){
    if (response.value!.length < 2){
      return const SizedBox();
    }
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2,),
          height: 24,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: const Text("Next Meeting", style: TextStyle(fontSize: 12,),),
        ),
        const SizedBox(width: 2,),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 18,
            child: Marquee(
              text: '${response.value![1].subject!} | ${response.value![1].organizer!.emailAddress!.name!} | ${_getNextMeetingTime(response)}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14,),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 50.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ),
      ],
    );
  }

  String _getNextMeetingTime(EventResponse response){
    String startDateTime = DateFormatUtil.formattedDateTimeAsString(response.value![1].start!.dateTime!);
    String endDateTime = DateFormatUtil.formattedDateTimeAsString(response.value![1].end!.dateTime!);
    return "$startDateTime - $endDateTime";
  }
}