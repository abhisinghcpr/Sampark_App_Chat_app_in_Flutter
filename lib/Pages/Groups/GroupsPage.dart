import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Config/Images.dart';
import '../../Controller/GroupController.dart';
import '../../Model/GroupModel.dart';
import '../GroupChat/GroupChat.dart';
import '../Home/Widget/ChatTile.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return StreamBuilder<List<GroupModel>>(
      stream: groupController.getGroupss(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<GroupModel>? groups = snapshot.data;
        return ListView.builder(
          itemCount: groups!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(GroupChatPage(groupModel: groups[index]));
              },
              child: ChatTile(
                name: groups[index].name!,
                imageUrl: groups[index].profileUrl == ""
                    ? AssetsImage.defaultProfileUrl
                    : groups[index].profileUrl!,
                lastChat: "Group Created",
                lastTime: "Just Now",
              ),
            );
          },
        );
      },
    );
  }
}
