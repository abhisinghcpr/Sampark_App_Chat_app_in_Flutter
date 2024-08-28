import 'package:flutter/material.dart';

import '../Welcome/Widgets/WelcomeHeading.dart';
import 'Widgets/AuthPageBody.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeading(),
                SizedBox(height: 60),
                AuthPageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
