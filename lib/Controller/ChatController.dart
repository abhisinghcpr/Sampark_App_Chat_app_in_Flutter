import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Controller/ProfileController.dart';
import 'package:sampark/Model/ChatRoomModel.dart';
import 'package:sampark/Model/UserMode.dart';
import 'package:uuid/uuid.dart';

import '../Model/ChatModel.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  ProfileController controller = Get.put(ProfileController());

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
<<<<<<< HEAD
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);

=======
    var sender = UserModel(
      id: auth.currentUser!.uid,
      name: controller.currentUser.value.name,
      email: controller.currentUser.value.email,
      profileImage: controller.currentUser.value.profileImage,
    );
    var newRoom = ChatRoomModel();
>>>>>>> 84cf6b35a00a59d18afff37dbec1a05b159043ea
    var newChat = ChatModel(
      id: chatId,
      message: message,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: controller.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimestamp: nowTime,
      sender: controller.currentUser.value,
      receiver: targetUser,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );
    try {
      await db.collection("chats").doc(roomId).set(
            roomDetails.toJson(),
          );
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(
            newChat.toJson(),
          );
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }
}
