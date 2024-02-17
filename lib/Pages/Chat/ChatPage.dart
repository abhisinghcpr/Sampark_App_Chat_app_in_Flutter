import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Controller/ChatController.dart';
import 'package:sampark/Model/UserMode.dart';
import 'package:sampark/Pages/Chat/Widgets/ChatBubble.dart';

import '../../Model/ChatModel.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(AssetsImage.boyPic),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userModel.name ?? "User",
                style: Theme.of(context).textTheme.bodyLarge),
            Text(
              "Online",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.phone,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_call,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                AssetsImage.chatMicSvg,
                width: 25,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                    filled: false, hintText: "Type message ..."),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 30,
              height: 30,
              child: SvgPicture.asset(
                AssetsImage.chatGallarySvg,
                width: 25,
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                if (messageController.text.isNotEmpty) {
                  chatController.sendMessage(
                      userModel.id!, messageController.text);
                  messageController.clear();
                }
              },
              child: Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  AssetsImage.chatSendSvg,
                  width: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            ChatBubble(
              message: "Hello How are you ?",
              imageUrl: "",
              isComming: true,
              status: "read",
              time: "10:10 AM",
            ),
            ChatBubble(
              message: "Hello How are you ?",
              imageUrl: "",
              isComming: false,
              status: "read",
              time: "10:10 AM",
            ),
            ChatBubble(
              message: "Hello How are you ?",
              imageUrl:
                  "https://th.bing.com/th/id/OIP.IZKOAibfR1kb-FaLtsCUGQHaEE?rs=1&pid=ImgDetMain",
              isComming: false,
              status: "read",
              time: "10:10 AM",
            ),
            ChatBubble(
              message: "Hello How are you ?",
              imageUrl: "",
              isComming: true,
              status: "read",
              time: "10:10 AM",
            ),
          ],
        ),
      ),
    );
  }
}
