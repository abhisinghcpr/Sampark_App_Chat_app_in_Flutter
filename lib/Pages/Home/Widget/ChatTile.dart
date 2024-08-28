import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/ChatController.dart';


class ChatTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastChat;
  final String lastTime;
  final String unReadMessageCount;
  const ChatTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.lastChat,
      required this.lastTime,
      this.unReadMessageCount = "0"});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: 06,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 5),
                      Text(
                        lastChat,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              // StreamBuilder(
              //   stream: chatController.getUnreadMessageCount(
              //       "Mp6yiJWt2RWzK5DFPZmroN843xX29SjvS2o0BJfBa80D2CWh2SgazMi1"),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData && snapshot.data == 0) {
              //       return Container();
              //     }
              //     return Container(
              //       width: 20,
              //       height: 20,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //         color: Theme.of(context).colorScheme.primary,
              //       ),
              //       child: Center(
              //         child: Text(
              //           snapshot.data.toString(),
              //           style: Theme.of(context)
              //               .textTheme
              //               .labelMedium
              //               ?.copyWith(
              //                 color: Theme.of(context).colorScheme.onBackground,
              //               ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              Text(
                lastTime,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
