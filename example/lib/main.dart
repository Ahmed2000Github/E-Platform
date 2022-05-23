import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Etudiant/screens/views/onboarding_page.dart';

// import 'Etudiant/screens/start_activity.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'irisiApp',
       theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: OnboardingPage(), 
    );
  }
}