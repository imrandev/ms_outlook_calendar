import 'package:flutter/material.dart';
import 'package:ms_outlook_calender/core/di/injection.dart';
import 'package:ms_outlook_calender/core/session/session_manager.dart';
import 'package:oauth2_client/oauth2_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final SessionManager _sessionManager = getIt<SessionManager>();

  String? _accessToken = '';

  void _incrementCounter() {
    authenticate();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Microsoft Graph API Access Token',
            ),
            Text(
              _accessToken != null ? _accessToken! : 'Token not found',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void authenticate() async {
    var client = OAuth2Client(
        authorizeUrl: 'https://login.microsoftonline.com/6622f8fa-db68-4b48-8608-e3f99e2d8dd1/oauth2/v2.0/authorize',
        tokenUrl: 'https://login.microsoftonline.com/6622f8fa-db68-4b48-8608-e3f99e2d8dd1/oauth2/v2.0/token',
        redirectUri: 'msauth://com.sqgc.ms_outlook_calender/7pcQFSNR9h5ruIgVBMyx9p/sniI=',
        customUriScheme: 'msauth',
    );
    print('authorizeUrl: ${client.authorizeUrl}');
    var token = await client.getTokenWithAuthCodeFlow(
        clientId: '89e15e51-e5aa-4986-8677-9e7feaf557dd',
        //clientSecret: '7Zw8Q~vvfOSkXGEcR7~7VN0SigGFUwdoqBApKc~.',
      // AccessReview.Read.All
        scopes: ['openid profile offline_access user.read user.read.all calendars.read calendars.readwrite Calendars.Read.Shared'],
    );
    print('accessToken: ${token.accessToken}');
    setState(() {
      _accessToken = token.accessToken;
    });
    _sessionManager.accessToken = token.accessToken;
    //print('errorDescription: ${token.errorDescription!}');
  }
}
