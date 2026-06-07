import 'package:flutter/material.dart';
import 'package:ostad_course_with_bd_apps/home_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeSelector(),
    );
  }
}
