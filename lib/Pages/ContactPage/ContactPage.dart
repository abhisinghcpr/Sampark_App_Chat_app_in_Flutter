import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Pages/ContactPage/Widgets/ConactSearch.dart';
import 'package:sampark/Pages/ContactPage/Widgets/NewContatcTile.dart';

import '../../Config/Images.dart';
import '../Home/Widget/ChatTile.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
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
              ontap: () {},
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Contacts on Sampark"),
              ],
            ),
            SizedBox(height: 10),
            Column(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
