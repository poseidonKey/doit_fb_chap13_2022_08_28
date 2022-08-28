import 'package:doit_chap13_fb/firebase_options.dart';
import 'package:doit_chap13_fb/memo_page.dart';
import 'package:doit_chap13_fb/tabs_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoPage(),
      // home: const MyHomePage(),
      // home: FirebaseApp(
      //   analytics: analytics,
      //   observer: observer,
      // ),
    );
  }
}

class FirebaseApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const FirebaseApp({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  @override
  State<FirebaseApp> createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  _FirebaseAppState(this.analytics, this.observer);
  String _message = "init";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _sendAnalyticsEvent,
              child: Text("Test"),
            ),
            Text(
              _message,
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<TabsPage>(
                builder: ((context) => TabsPage(observer: observer)),
                settings: RouteSettings(name: "/tab")),
          );
        },
        child: Icon(Icons.tab),
      ),
    );
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
        name: "test_event",
        parameters: <String, dynamic>{"string": "Hello flutter", "int": 100});
    setMesaage("Analytics Succeess");
  }

  void setMesaage(String message) {
    setState(() {
      _message = message;
    });
  }
}
