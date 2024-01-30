import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realtime_quiz/firebase_options.dart';
import 'package:realtime_quiz/quiz_app/pin_code_page.dart';
import 'package:realtime_quiz/web/quiz_manager_page.dart';

FirebaseDatabase? database;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String host = "";
  String baseUrl = "";

  // host = "http://10.0.2.2:9000";
  // baseUrl = "127.0.0.1";

  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      host = "http://10.0.2.2:9000";
      baseUrl = "127.0.0.1";
    } else {
      host = "http://localhost:9000";
      baseUrl = "127.0.0.1";
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: "$host?ns=realtime-quiz-wtg-v1-d7427-default-rtdb"  //local emulator를 위한 설정
  );
    // FirebaseDatabase.instance;  firebase 콘솔에서 직접 가져올 경우

  await FirebaseAuth.instance.useAuthEmulator(baseUrl, 9099);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      return MaterialApp(
        title: "실시간 퀴즈 앱",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PinCodePage(),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '패스트캠퍼스 실시간 퀴즈앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuizManagerPage(),
    );
  }
}

