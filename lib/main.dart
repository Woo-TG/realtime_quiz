import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_quiz/firebase_options.dart';
import 'package:realtime_quiz/web/quiz_manager_page.dart';

FirebaseDatabase? database;

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String host = "";
  String baseUrl = "";

  host = "http://localhost:9000";
  baseUrl = "127.0.0.1";
  
  database = FirebaseDatabase.instanceFor(app: Firebase.app(),
   databaseURL: "$host?ns=realtime-quiz-wtg-v1-d7427"
  );

  await FirebaseAuth.instance.useAuthEmulator(baseUrl, 9099);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

