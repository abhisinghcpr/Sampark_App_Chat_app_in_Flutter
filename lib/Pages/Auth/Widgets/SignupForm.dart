import 'package:flutter/material.dart';
import 'package:sampark/Widget/PrimaryButton.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 40),
        TextField(
          decoration: InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(
              Icons.person,
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.alternate_email_rounded,
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            hintText: "Passowrd",
            prefixIcon: Icon(
              Icons.password_outlined,
            ),
          ),
        ),
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(btnName: "SIGNUP", icon: Icons.lock_open_outlined),
          ],
        )
      ],
    );
  }
}
