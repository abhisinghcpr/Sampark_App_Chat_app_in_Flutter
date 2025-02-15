// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../Config/Images.dart';
// import '../../../Controller/ChatController.dart';
// import '../../../Controller/ImagePicker.dart';
// import '../../../Model/UserMode.dart';
// import '../../../Widget/ImagePickerBottomSeet.dart';
//
// class TypeMessage extends StatelessWidget {
//   final UserModel userModel;
//   const TypeMessage({super.key, required this.userModel});
//
//   @override
//   Widget build(BuildContext context) {
//     ChatController chatController = Get.put(ChatController());
//     TextEditingController messageController = TextEditingController();
//     RxString message = "".obs;
//     ImagePickerController imagePickerController =
//         Get.put(ImagePickerController());
//
//     return Container(
//       // margin: EdgeInsets.all(10),
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),
//           color: Theme.of(context).colorScheme.primaryContainer),
//       child: Row(
//         children: [
//           Container(
//             width: 30,
//             height: 30,
//             child: SvgPicture.asset(
//               AssetsImage.chatEmoji,
//               width: 25,
//             ),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: TextField(
//               onChanged: (value) {
//                 message.value = value;
//                 print("typing...");
//                 if (value.isNotEmpty) {
//                   print("typing...");
//                 } else {
//                   print("not typing");
//                 }
//               },
//               onEditingComplete: () {
//                 print("onEditingComplete");
//               },
//               controller: messageController,
//               decoration: const InputDecoration(
//                   filled: false, hintText: "Type message ..."),
//             ),
//           ),
//           SizedBox(width: 10),
//           Obx(
//             () => chatController.selectedImagePath.value == ""
//                 ? InkWell(
//                     onTap: () {
//                       ImagePickerBottomSheet(
//                           context,
//                           chatController.selectedImagePath,
//                           imagePickerController);
//                     },
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       child: SvgPicture.asset(
//                         AssetsImage.chatGallarySvg,
//                         width: 25,
//                       ),
//                     ),
//                   )
//                 : SizedBox(),
//           ),
//           SizedBox(width: 10),
//           Obx(
//             () => message.value != "" ||
//                     chatController.selectedImagePath.value != ""
//                 ? InkWell(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     onTap: () {
//                       if (messageController.text.isNotEmpty ||
//                           chatController.selectedImagePath.value.isNotEmpty) {
//                         chatController.sendMessage(
//                             userModel.id!, messageController.text, userModel);
//                         messageController.clear();
//                         message.value = "";
//                       }
//                     },
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       child: chatController.isLoading.value
//                           ? CircularProgressIndicator()
//                           : SvgPicture.asset(
//                               AssetsImage.chatSendSvg,
//                               width: 25,
//                             ),
//                     ),
//                   )
//                 : Container(
//                     width: 30,
//                     height: 30,
//                     child: SvgPicture.asset(
//                       AssetsImage.chatMicSvg,
//                       width: 25,
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji_picker;
import 'dart:io';
import '../../../Config/Images.dart';
import '../../../Controller/ChatController.dart';
import '../../../Controller/ImagePicker.dart';
import '../../../Model/UserMode.dart';
import '../../../Widget/ImagePickerBottomSeet.dart';

class TypeMessage extends StatefulWidget {
  final UserModel userModel;
  const TypeMessage({Key? key, required this.userModel}) : super(key: key);

  @override
  _TypeMessageState createState() => _TypeMessageState();
}

class _TypeMessageState extends State<TypeMessage> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxBool showEmojiPicker = false.obs;
  final RxString message = "".obs;

  late ChatController chatController;
  late ImagePickerController imagePickerController;

  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController());
    imagePickerController = Get.put(ImagePickerController());
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showEmojiPicker.value = false;
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void toggleEmojiPicker() {
    if (showEmojiPicker.value) {
      showEmojiPicker.value = false;
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      showEmojiPicker.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: toggleEmojiPicker,
                child: Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    AssetsImage.chatEmoji,
                    width: 25,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  controller: messageController,
                  onChanged: (value) {
                    message.value = value;
                    print(value.isNotEmpty ? "typing..." : "not typing");
                  },
                  onEditingComplete: () {
                    print("onEditingComplete");
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: "Type message ...",
                  ),
                ),
              ),
              SizedBox(width: 10),
              Obx(
                    () => chatController.selectedImagePath.value == ""
                    ? InkWell(
                  onTap: () {
                    ImagePickerBottomSheet(
                      context,
                      chatController.selectedImagePath,
                      imagePickerController,
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      AssetsImage.chatGallarySvg,
                      width: 25,
                    ),
                  ),
                )
                    : SizedBox(),
              ),
              SizedBox(width: 10),
              Obx(
                    () => message.value != "" ||
                    chatController.selectedImagePath.value != ""
                    ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (messageController.text.isNotEmpty ||
                        chatController.selectedImagePath.value.isNotEmpty) {
                      chatController.sendMessage(
                        widget.userModel.id!,
                        messageController.text,
                        widget.userModel,
                      );
                      messageController.clear();
                      message.value = "";
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: chatController.isLoading.value
                        ? CircularProgressIndicator()
                        : SvgPicture.asset(
                      AssetsImage.chatSendSvg,
                      width: 25,
                    ),
                  ),
                )
                    : Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    AssetsImage.chatMicSvg,
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() => showEmojiPicker.value
            ? SizedBox(
          height: 250,
          child: emoji_picker.EmojiPicker(
            onEmojiSelected: (category, emoji) {
              messageController.text += emoji.emoji;
              message.value = messageController.text;
            },
            onBackspacePressed: () {
              messageController
                ..text = messageController.text.characters.skipLast(1).toString()
                ..selection = TextSelection.fromPosition(
                    TextPosition(offset: messageController.text.length));
              message.value = messageController.text;
            },
            textEditingController: messageController,
            config: Config(
              height: 256,
              checkPlatformCompatibility: true,
              emojiViewConfig: EmojiViewConfig(
                emojiSizeMax: 28 *
                    (defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.20
                        : 1.0),
              ),
              viewOrderConfig: const ViewOrderConfig(
                top: EmojiPickerItem.categoryBar,
                middle: EmojiPickerItem.emojiView,
                bottom: EmojiPickerItem.searchBar,
              ),
              skinToneConfig: const SkinToneConfig(),
              categoryViewConfig: const CategoryViewConfig(),
              bottomActionBarConfig: const BottomActionBarConfig(),
              searchViewConfig: const SearchViewConfig(),
            ),
          ),
        )
            : SizedBox()),
      ],
    );
  }
}