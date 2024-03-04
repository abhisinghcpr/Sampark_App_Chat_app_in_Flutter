import 'package:flutter/material.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Pages/Home/Widget/ChatTile.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatTile(
          imageUrl: AssetsImage.defaultProfileUrl,
          name: "Study Group",
          lastChat: "Last Message",
          lastTime: "Last Time",
        ),
      ],
    );
  }
}
