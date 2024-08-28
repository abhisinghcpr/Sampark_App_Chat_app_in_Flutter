// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';
// // import 'package:uuid/uuid.dart';
// // import '../Model/AudioCall.dart';
// // import '../Model/UserMode.dart';
// // import '../Pages/CallPage/AudioCallPage.dart';
// // import '../Pages/CallPage/VideoCall.dart';
// //
// // class CallController extends GetxController {
// //   final db = FirebaseFirestore.instance;
// //   final auth = FirebaseAuth.instance;
// //   final uuid = Uuid().v4();
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //
// //     getCallsNotification().listen((List<CallModel> callList) {
// //       if (callList.isNotEmpty) {
// //         var callData = callList[0];
// //         if (callData.type == "audio") {
// //           audioCallNotification(callData);
// //         } else if (callData.type == "video") {
// //           videoCallNotification(callData);
// //         }
// //       }
// //     });
// //   }
// //
// //   Future<void> audioCallNotification(CallModel callData) async {
// //     Get.snackbar(
// //       duration: Duration(days: 1),
// //       barBlur: 0,
// //       backgroundColor: Colors.grey[900]!,
// //       isDismissible: false,
// //       icon: Icon(Icons.call),
// //       onTap: (snack) {
// //         Get.back();
// //         Get.to(
// //           AudioCallPage(
// //             target: UserModel(
// //               id: callData.callerUid,
// //               name: callData.callerName,
// //               email: callData.callerEmail,
// //               profileImage: callData.callerPic,
// //             ),
// //           ),
// //         );
// //       },
// //       callData.callerName!,
// //       "Incoming Audio Call",
// //       mainButton: TextButton(
// //         onPressed: () {
// //           endCall(callData);
// //           Get.back();
// //         },
// //         child: Text("End Call"),
// //       ),
// //     );
// //   }
// //
// //   Future<void> callAction(
// //       UserModel reciver, UserModel caller, String type) async {
// //     String id = uuid;
// //     DateTime timestamp = DateTime.now();
// //     String nowTime = DateFormat('hh:mm a').format(timestamp);
// //     var newCall = CallModel(
// //       id: id,
// //       callerName: caller.name,
// //       callerPic: caller.profileImage,
// //       callerUid: caller.id,
// //       callerEmail: caller.email,
// //       receiverName: reciver.name,
// //       receiverPic: reciver.profileImage,
// //       receiverUid: reciver.id,
// //       receiverEmail: reciver.email,
// //       status: "dialing",
// //       type: type,
// //       time: nowTime,
// //       timestamp: DateTime.now().toString(),
// //     );
// //
// //     try {
// //       await db
// //           .collection("notification")
// //           .doc(reciver.id)
// //           .collection("call")
// //           .doc(id)
// //           .set(newCall.toJson());
// //       await db
// //           .collection("users")
// //           .doc(auth.currentUser!.uid)
// //           .collection("calls")
// //           .add(newCall.toJson());
// //       await db
// //           .collection("users")
// //           .doc(reciver.id)
// //           .collection("calls")
// //           .add(newCall.toJson());
// //       Future.delayed(Duration(seconds: 20), () {
// //         endCall(newCall);
// //       });
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// //
// //   Stream<List<CallModel>> getCallsNotification() {
// //     return FirebaseFirestore.instance
// //         .collection("notification")
// //         .doc(auth.currentUser!.uid)
// //         .collection("call")
// //         .snapshots()
// //         .map((snapshot) => snapshot.docs
// //             .map((doc) => CallModel.fromJson(doc.data()))
// //             .toList());
// //   }
// //
// //   Future<void> endCall(CallModel call) async {
// //     try {
// //       await db
// //           .collection("notification")
// //           .doc(call.receiverUid)
// //           .collection("call")
// //           .doc(call.id)
// //           .delete();
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// //
// //   void videoCallNotification(CallModel callData) {
// //     Get.snackbar(
// //       duration: Duration(days: 1),
// //       barBlur: 0,
// //       backgroundColor: Colors.grey[900]!,
// //       isDismissible: false,
// //       icon: Icon(Icons.video_call),
// //       onTap: (snack) {
// //         Get.back();
// //         Get.to(
// //           VideoCallPage(
// //             target: UserModel(
// //               id: callData.callerUid,
// //               name: callData.callerName,
// //               email: callData.callerEmail,
// //               profileImage: callData.callerPic,
// //             ),
// //           ),
// //         );
// //       },
// //       callData.callerName!,
// //       "Incoming Video Call",
// //       mainButton: TextButton(
// //         onPressed: () {
// //           endCall(callData);
// //           Get.back();
// //         },
// //         child: Text("End Call"),
// //       ),
// //     );
// //   }
// //
// //
// //
// //
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
// import '../Model/AudioCall.dart';
// import '../Model/UserMode.dart';
// import '../Pages/CallPage/AudioCallPage.dart';
//
// class CallController extends GetxController {
//   final db = FirebaseFirestore.instance;
//   final auth = FirebaseAuth.instance;
//   final uuid = Uuid().v4();
//
//   void onInit() {
//     super.onInit();
//
//     getCallsNotification().listen((List<CallModel> callList) {
//       if (callList.isNotEmpty) {
//         var callData = callList[0];
//         Get.snackbar(
//           duration: Duration(days: 1),
//           barBlur: 0,
//           backgroundColor: Colors.grey[900]!,
//           isDismissible: false,
//           icon: Icon(Icons.call),
//           onTap: (snack) {
//             Get.back();
//             Get.to(
//               AudioCallPage(
//                 target: UserModel(
//                   id: callData.callerUid,
//                   name: callData.callerName,
//                   email: callData.callerEmail,
//                   profileImage: callData.callerPic,
//                 ),
//               ),
//             );
//           },
//           callData.callerName!,
//           "Incoming Call",
//           mainButton: TextButton(
//             onPressed: () {
//               endCall(callData);
//               Get.back();
//             },
//             child: Text("End Call"),
//           ),
//         );
//       }
//     });
//   }
//
//   Future<void> callAction(UserModel reciver, UserModel caller, ) async {
//     String id = uuid;
//     var newCall = CallModel(
//       id: id,
//       callerName: caller.name,
//       callerPic: caller.profileImage,
//       callerUid: caller.id,
//       callerEmail: caller.email,
//       receiverName: reciver.name,
//       receiverPic: reciver.profileImage,
//       receiverUid: reciver.id,
//       receiverEmail: reciver.email,
//       status: "dialing",
//     );
//
//     try {
//       await db
//           .collection("notification")
//           .doc(reciver.id)
//           .collection("call")
//           .doc(id)
//           .set(newCall.toJson());
//       await db
//           .collection("users")
//           .doc(auth.currentUser!.uid)
//           .collection("calls")
//           .doc(id)
//           .set(newCall.toJson());
//       await db
//           .collection("users")
//           .doc(reciver.id)
//           .collection("calls")
//           .doc(id)
//           .set(newCall.toJson());
//       Future.delayed(Duration(seconds: 20), () {
//         endCall(newCall);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Stream<List<CallModel>> getCallsNotification() {
//     return FirebaseFirestore.instance
//         .collection("notification")
//         .doc(auth.currentUser!.uid)
//         .collection("call")
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => CallModel.fromJson(doc.data()))
//         .toList());
//   }
//
//   Future<void> endCall(CallModel call) async {
//     try {
//       await db
//           .collection("notification")
//           .doc(call.receiverUid)
//           .collection("call")
//           .doc(call.id)
//           .delete();
//     } catch (e) {
//       print(e);
//     }
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../Model/AudioCall.dart';
import '../Model/UserMode.dart';
import '../Pages/CallPage/AudioCallPage.dart';

// class CallController extends GetxController {
//   final db = FirebaseFirestore.instance;
//   final auth = FirebaseAuth.instance;
//   final uuid = Uuid().v4();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getCallsNotification().listen((List<CallModel> callList) {
//       if (callList.isNotEmpty) {
//         var callData = callList[0];
//         Get.snackbar(
//           "Incoming Call",
//           callData.callerName!,
//           duration: Duration(days: 1),
//           barBlur: 0,
//           backgroundColor: Colors.grey[900]!,
//           isDismissible: false,
//           icon: Icon(Icons.call),
//           onTap: (snack) {
//             Get.back();
//             Get.to(
//               AudioCallPage(
//                 target: UserModel(
//                   id: callData.callerUid,
//                   name: callData.callerName,
//                   email: callData.callerEmail,
//                   profileImage: callData.callerPic,
//                 ),
//               ),
//             );
//           },
//           mainButton: TextButton(
//             onPressed: () {
//               endCall(callData);
//               Get.back();
//             },
//             child: Text("End Call"),
//           ),
//         );
//       }
//     });
//   }
//
//   Future<void> callAction(UserModel receiver, UserModel caller) async {
//     String id = uuid;
//     var newCall = CallModel(
//       id: id,
//       callerName: caller.name,
//       callerPic: caller.profileImage,
//       callerUid: caller.id,
//       callerEmail: caller.email,
//       receiverName: receiver.name,
//       receiverPic: receiver.profileImage,
//       receiverUid: receiver.id,
//       receiverEmail: receiver.email,
//       status: "dialing",
//     );
//
//     try {
//       await db
//           .collection("notification")
//           .doc(receiver.id)
//           .collection("call")
//           .doc(id)
//           .set(newCall.toJson());
//
//       await db
//           .collection("users")
//           .doc(auth.currentUser!.uid)
//           .collection("calls")
//           .doc(id)
//           .set(newCall.toJson());
//
//       await db
//           .collection("users")
//           .doc(receiver.id)
//           .collection("calls")
//           .doc(id)
//           .set(newCall.toJson());
//
//       Future.delayed(Duration(seconds: 20), () {
//         endCall(newCall);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Stream<List<CallModel>> getCallsNotification() {
//     return db
//         .collection("notification")
//         .doc(auth.currentUser!.uid)
//         .collection("call")
//         .snapshots()
//         .map((snapshot) =>
//         snapshot.docs.map((doc) => CallModel.fromJson(doc.data())).toList());
//   }
//
//   Future<void> endCall(CallModel call) async {
//     try {
//       await db
//           .collection("notification")
//           .doc(call.receiverUid)
//           .collection("call")
//           .doc(call.id)
//           .delete();
//     } catch (e) {
//       print(e);
//     }
//   }
// }



class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();

  @override
  void onInit() {
    super.onInit();

    enableFirestorePersistence();

    getCallsNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        showIncomingCallBottomSheet(callData);
      }
    });
  }

  Future<void> enableFirestorePersistence() async {
    try {
      await FirebaseFirestore.instance.enablePersistence();
    } catch (e) {
      print('Error enabling Firestore persistence: $e');
    }
  }

  void showIncomingCallBottomSheet(CallModel callData) {
    Get.bottomSheet(
      Container(
        color: Colors.grey[900],
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Incoming Call from ${callData.callerName}",
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    endCall(callData);
                    Get.back();

                  },

                  child: Icon(Icons.call_end, color: Colors.white),
                ),


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    receiveCall(callData);
                    Get.back();

                    Get.to(AudioCallPage(
                      target: UserModel(
                        id: callData.callerUid,
                        name: callData.callerName,
                        email: callData.callerEmail,
                        profileImage: callData.callerPic,
                      ),
                    ));
                  },
                  child: Icon(Icons.call, color: Colors.white),
                ),

              ],
            ),
          ],
        ),
      ),
      isDismissible: false,
    );
  }

  Future<void> callAction(UserModel receiver, UserModel caller) async {
    String id = uuid;
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverName: receiver.name,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.id,
      receiverEmail: receiver.email,
      status: "dialing",
    );

    try {
      await db.collection("users").doc(auth.currentUser!.uid).collection("calls").doc(id).set(newCall.toJson());

      newCall.status = "incoming";
      await db.collection("notification").doc(receiver.id).collection("call").doc(id).set(newCall.toJson());

      Future.delayed(Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      handleNetworkError(e);
    }
  }

  Stream<List<CallModel>> getCallsNotification() {
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CallModel.fromJson(doc.data())).toList());
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db.collection("notification").doc(call.receiverUid).collection("call").doc(call.id).delete();
      await db.collection("users").doc(call.callerUid).collection("calls").doc(call.id).delete();
    } catch (e) {
      handleNetworkError(e);
    }
  }

  Future<void> receiveCall(CallModel call) async {
    try {
      await db.collection("users").doc(call.receiverUid).collection("calls").doc(call.id).update({'status': 'in_call'});
      await db.collection("users").doc(call.callerUid).collection("calls").doc(call.id).update({'status': 'in_call'});
    } catch (e) {
      handleNetworkError(e);
    }
  }

  void handleNetworkError(dynamic error) {
    print('Network error occurred: $error');
  }
}



