import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Widgets/WelcomeBody.dart';
import 'Widgets/WelcomeFooterButton.dart';
import 'Widgets/WelcomeHeading.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WelcomeHeading(),
              WelcomeBody(),
              WelcomeFooterbutton(),
            ],
          ),
        ),
      ),
    );
  }
}
