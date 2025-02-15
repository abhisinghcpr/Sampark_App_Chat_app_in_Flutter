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
import 'package:flutter/foundation.dart'; // Import foundation for `defaultTargetPlatform`
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Your other imports...

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
                ..text = messageController.text.characters
                    .skipLast(1)
                    .toString()
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



