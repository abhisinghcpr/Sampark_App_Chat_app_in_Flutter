import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/Images.dart';
import 'package:sampark/Controller/ContactController.dart';
import 'package:sampark/Pages/Chat/ChatPage.dart';
import 'package:sampark/Pages/Home/Widget/ChatTile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    return RefreshIndicator(
      child: Obx(
        () => ListView(
          children: contactController.chatRoomList
              .map(
                (e) => InkWell(
                  onTap: () {
                    Get.to(ChatPage(userModel: e.receiver!));
                  },
                  child: ChatTile(
                    imageUrl: e.receiver!.profileImage ??
                        AssetsImage.defaultProfileUrl,
                    name: e.receiver!.name ?? "User Name",
                    lastChat: e.lastMessage ?? "Last Message",
                    lastTime: e.lastMessageTimestamp ?? "Last Time",
                  ),
                ),
              )
              .toList(),
        ),
      ),
      onRefresh: () {
        return contactController.getChatRoomList();
      },
    );
  }
}
