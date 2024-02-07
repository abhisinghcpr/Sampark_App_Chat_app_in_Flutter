import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Pages/Home/Widget/ChatTile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed("/chatPage");
          },
          child: ChatTile(
            imageUrl: AssetsImage.girlPic,
            name: "SSSA KUMARI",
            lastChat: "Bad me bat krte hai",
            lastTime: "09:23 PM",
          ),
        ),
        ChatTile(
          imageUrl: AssetsImage.boyPic,
          name: "Nitish kumar",
          lastChat: "Abhi bat krte hai ",
          lastTime: "09:23 PM",
        ),
        ChatTile(
          imageUrl: AssetsImage.girlPic,
          name: "SSSA KUMARI",
          lastChat: "Bad me bat krte hai",
          lastTime: "09:23 PM",
        ),
        ChatTile(
          imageUrl: AssetsImage.boyPic,
          name: "Nitish kumar",
          lastChat: "Abhi bat krte hai ",
          lastTime: "09:23 PM",
        ),
        ChatTile(
          imageUrl: AssetsImage.girlPic,
          name: "SSSA KUMARI",
          lastChat: "Bad me bat krte hai",
          lastTime: "09:23 PM",
        ),
        ChatTile(
          imageUrl: AssetsImage.boyPic,
          name: "Nitish kumar",
          lastChat: "Abhi bat krte hai ",
          lastTime: "09:23 PM",
        ),
        ChatTile(
          imageUrl: AssetsImage.girlPic,
          name: "SSSA KUMARI",
          lastChat: "Bad me bat krte hai",
          lastTime: "09:23 PM",
        ),
        ChatTile(
          imageUrl: AssetsImage.boyPic,
          name: "Nitish kumar",
          lastChat: "Abhi bat krte hai ",
          lastTime: "09:23 PM",
        ),
      ],
    );
  }
}
