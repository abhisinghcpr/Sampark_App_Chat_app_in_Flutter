import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/ChatController.dart';
import 'package:sampark/Controller/ContactController.dart';
import 'package:sampark/Controller/ProfileController.dart';
import 'package:sampark/Pages/Chat/ChatPage.dart';
import 'package:sampark/Pages/ContactPage/Widgets/ConactSearch.dart';
import 'package:sampark/Pages/ContactPage/Widgets/NewContatcTile.dart';
import 'package:sampark/Pages/Groups/NewGroup/NewGroup.dart';

import '../../Config/Images.dart';
import '../Home/Widget/ChatTile.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Select contact"),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon:
                  isSearchEnable.value ? Icon(Icons.close) : Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value ? ContactSearch() : SizedBox(),
            ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: "New contact",
              icon: Icons.person_add,
              ontap: () {},
            ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontap: () {
                Get.to(NewGroup());
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Contacts on Sampark"),
              ],
            ),
            SizedBox(height: 10),
            Obx(
              () => Column(
                children: contactController.userList
                    .map(
                      (e) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.to(ChatPage(userModel: e));
                        },
                        child: ChatTile(
                          imageUrl:
                              e.profileImage ?? AssetsImage.defaultProfileUrl,
                          name: e.name ?? "User",
                          lastChat: e.about ?? "Hey there",
                          lastTime: e.email ==
                                  profileController.currentUser.value.email
                              ? "You"
                              : "",
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
