import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Pages/Profile/Widgets/UserInfo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: const Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            LoginUserInfo(),
          ],
        ),
      ),
    );
  }
}
