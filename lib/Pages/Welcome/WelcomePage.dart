import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Config/Strings.dart';
import 'package:sampark/Pages/Welcome/Widgets/WelcomeBody.dart';
import 'package:sampark/Pages/Welcome/Widgets/WelcomeFooterButton.dart';
import 'package:sampark/Pages/Welcome/Widgets/WelcomeHeading.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
