// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../Config/Images.dart';
// import '../../Controller/ChatController.dart';
// import '../../Controller/ProfileController.dart';
//
// class CallHistory extends StatelessWidget {
//   const CallHistory({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     ChatController chatController = Get.put(ChatController());
//     ProfileController profileController = Get.put(ProfileController());
//     return StreamBuilder(
//         stream: chatController.getCalls(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 DateTime timestamp =
//                     DateTime.parse(snapshot.data![index].timestamp!);
//                 String formattedTime = DateFormat('hh:mm a').format(timestamp);
//                 return ListTile(
//                   leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: CachedNetworkImage(
//                         imageUrl: snapshot.data![index].callerUid ==
//                                 profileController.currentUser.value.id
//                             ? snapshot.data![index].receiverPic == null
//                                 ? AssetsImage.defaultProfileUrl
//                                 : snapshot.data![index].receiverPic!
//                             : snapshot.data![index].callerPic == null
//                                 ? AssetsImage.defaultProfileUrl
//                                 : snapshot.data![index].callerPic!,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) =>
//                             CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       )),
//                   title: Text(
//                     snapshot.data![index].callerUid ==
//                             profileController.currentUser.value.id
//                         ? snapshot.data![index].receiverName!
//                         : snapshot.data![index].callerName!,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   subtitle: Text(
//                     formattedTime,
//                     style: Theme.of(context).textTheme.labelMedium,
//                   ),
//                   trailing: snapshot.data![index].type == "video"
//                       ? IconButton(
//                           icon: Icon(Icons.video_call),
//                           onPressed: () {},
//                         )
//                       : IconButton(
//                           icon: Icon(Icons.call),
//                           onPressed: () {},
//                         ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: SizedBox(
//                 width: 200,
//                 height: 200,
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         });
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Config/Images.dart';
import '../../Controller/ChatController.dart';
import '../../Controller/ProfileController.dart';
import '../../Model/AudioCall.dart';


class CallHistory extends StatelessWidget {
  const CallHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      body: StreamBuilder<List<CallModel>>(
        stream: chatController.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No call history available'));
          }

          List<CallModel> calls = snapshot.data!;

          return ListView.builder(
            itemCount: calls.length,
            itemBuilder: (context, index) {
              CallModel call = calls[index];

              DateTime? timestamp = call.timestamp != null ? DateTime.tryParse(call.timestamp!) : null;
              String formattedTime = timestamp != null
                  ? DateFormat('dd MMM yyyy, hh:mm a').format(timestamp)
                  : 'Unknown time';

              return Dismissible(
                key: Key(call.id ?? index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm"),
                        content: Text("Are you sure you want to delete this call history?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("CANCEL"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("DELETE"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  if (call.id != null) {
                    chatController.deleteCall(call.id!).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Call history deleted")),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to delete call history: $error")),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid call ID")),
                    );
                  }
                },
                child: CallHistoryTile(call: call, profileController: profileController),
              );
            },
          );
        },
      ),
    );
  }
}

class CallHistoryTile extends StatelessWidget {
  final CallModel call;
  final ProfileController profileController;

  const CallHistoryTile({
    Key? key,
    required this.call,
    required this.profileController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Safely handle null values in the timestamp
    DateTime? timestamp = call.timestamp != null ? DateTime.tryParse(call.timestamp!) : null;
    String formattedTime = timestamp != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(timestamp)
        : 'Unknown time';

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          imageUrl: call.callerUid == profileController.currentUser.value?.id
              ? call.receiverPic ?? AssetsImage.defaultProfileUrl
              : call.callerPic ?? AssetsImage.defaultProfileUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          placeholder: (context, url) => CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(
        call.callerUid == profileController.currentUser.value?.id
            ? call.receiverName ?? 'Unknown Name'
            : call.callerName ?? 'Unknown Name',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        formattedTime,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: Icon(
        call.type == "video" ? Icons.videocam : Icons.call,
        color: Colors.blue,
      ),
    );
  }
}






