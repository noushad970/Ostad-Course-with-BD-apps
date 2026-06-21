import 'package:flutter/material.dart';
import 'package:ostad_course_with_bd_apps/pages/learning_page.dart';
import 'package:ostad_course_with_bd_apps/pages/profile.dart';
import 'package:ostad_course_with_bd_apps/quiz_page.dart';

class HomeSelector extends StatelessWidget {
  const HomeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ImagePage()));
                  },
                  child: const Text('Open Learning Page'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProfilePage()));
                  },
                  child: const Text('Open Profile Page'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const QuizHomePage()));
                  },
                  child: const Text('Open Quiz Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
