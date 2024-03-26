import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Controller/ChatController.dart';
import 'package:sampark/Pages/Home/Widget/ChatTile.dart';

import '../../Config/Images.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DateTime timestamp =
                    DateTime.parse(snapshot.data![index].timestamp!);
                String formattedTime = DateFormat('hh:mm a').format(timestamp);
                return ChatTile(
                  imageUrl: snapshot.data![index].callerPic ??
                      AssetsImage.defaultProfileUrl,
                  name: snapshot.data![index].callerName ?? "...",
                  lastChat: snapshot.data![index].type ?? "...",
                  lastTime: formattedTime,
                );
              },
            );
          } else {
            return Center(
              child: Container(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
