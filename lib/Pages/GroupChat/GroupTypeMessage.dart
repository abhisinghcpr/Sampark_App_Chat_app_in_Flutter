// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../Config/Images.dart';
// import '../../../Controller/ImagePicker.dart';
// import '../../../Widget/ImagePickerBottomSeet.dart';
// import '../../Controller/GroupController.dart';
// import '../../Model/GroupModel.dart';
//
// class GroupTypeMessage extends StatelessWidget {
//   final GroupModel groupModel;
//   const GroupTypeMessage({super.key, required this.groupModel});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController messageController = TextEditingController();
//     RxString message = "".obs;
//     ImagePickerController imagePickerController =
//         Get.put(ImagePickerController());
//     GroupController groupController = Get.put(GroupController());
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
//               },
//               controller: messageController,
//               decoration: const InputDecoration(
//                   filled: false, hintText: "Type message ..."),
//             ),
//           ),
//           SizedBox(width: 10),
//           Obx(
//             () => groupController.selectedImagePath.value == ""
//                 ? InkWell(
//                     onTap: () {
//                       ImagePickerBottomSheet(
//                           context,
//                           groupController.selectedImagePath,
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
//                     groupController.selectedImagePath.value != ""
//                 ? InkWell(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     onTap: () {
//                       groupController.sendGroupMessage(
//                         messageController.text,
//                         groupModel.id!,
//                         "",
//                       );
//                       messageController.clear();
//                       message.value = "";
//                     },
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       child: groupController.isLoading.value
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


import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../../../Config/Images.dart';
import '../../../Controller/ImagePicker.dart';
import '../../../Widget/ImagePickerBottomSeet.dart';
import '../../Controller/GroupController.dart';
import '../../Model/GroupModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji_picker;
class GroupTypeMessage extends StatefulWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({Key? key, required this.groupModel}) : super(key: key);

  @override
  _GroupTypeMessageState createState() => _GroupTypeMessageState();
}

class _GroupTypeMessageState extends State<GroupTypeMessage> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final RxBool showEmojiPicker = false.obs;
  final RxString message = "".obs;

  late ImagePickerController imagePickerController;
  late GroupController groupController;

  @override
  void initState() {
    super.initState();
    imagePickerController = Get.put(ImagePickerController());
    groupController = Get.put(GroupController());
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
                  onChanged: (value) => message.value = value,
                  onTap: () {
                    if (showEmojiPicker.value) {
                      showEmojiPicker.value = false;
                    }
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: "Type message ...",
                  ),
                ),
              ),
              SizedBox(width: 10),
              Obx(
                    () => groupController.selectedImagePath.value == ""
                    ? InkWell(
                  onTap: () {
                    ImagePickerBottomSheet(
                        context,
                        groupController.selectedImagePath,
                        imagePickerController);
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
                    groupController.selectedImagePath.value != ""
                    ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    groupController.sendGroupMessage(
                      messageController.text,
                      widget.groupModel.id!,
                      "",
                    );
                    messageController.clear();
                    message.value = "";
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: groupController.isLoading.value
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
          child: EmojiPicker(
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
            config: emoji_picker.Config(
              columns: 7,
              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: emoji_picker.Category.RECENT,
              bgColor: Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: emoji_picker.RecentTabBehavior.RECENT,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
              loadingIndicator: const SizedBox.shrink(),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const emoji_picker.CategoryIcons(),
              buttonMode: emoji_picker.ButtonMode.MATERIAL,
            ),
          ),
        )
            : SizedBox()),
      ],
    );
  }
}