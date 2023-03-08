import 'package:flutter/material.dart';
import 'package:ms_outlook_calender/core/bloc/bloc.dart';
import 'package:ms_outlook_calender/core/di/injection.dart';
import 'package:ms_outlook_calender/presentation/bloc/home_bloc.dart';
import 'package:ms_outlook_calender/presentation/ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MeetingRoomApp());
}

class MeetingRoomApp extends StatelessWidget {
  const MeetingRoomApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting Room',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(bloc: HomeBloc(), child: const HomePage()),
      //home: const MyHomePage(title: ""),
      debugShowCheckedModeBanner: false,
    );
  }
}
