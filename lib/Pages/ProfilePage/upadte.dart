import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Controller/ImagePicker.dart';
import '../../Controller/ProfileController.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final ImagePickerController imagePickerController =
  Get.put(ImagePickerController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  EditProfilePage({super.key}) {
    nameController.text = profileController.currentUser.value.name ?? "";
    aboutController.text = profileController.currentUser.value.about ?? "";
  }

  @override
  Widget build(BuildContext context) {
    RxString imagePath = "".obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Image
            Obx(
                  () => GestureDetector(
                onTap: () async {
                  imagePath.value = await imagePickerController.pickImage(
                    ImageSource.gallery,
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imagePath.value.isNotEmpty
                      ? FileImage(File(imagePath.value))
                      : profileController.currentUser.value.profileImage != null
                      ? NetworkImage(
                      profileController.currentUser.value.profileImage!)
                      : const AssetImage("assets/placeholder.png")
                  as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Name Field
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            // About Field
            TextField(
              controller: aboutController,
              decoration: const InputDecoration(
                labelText: "About",
                prefixIcon: Icon(Icons.info),
              ),
            ),
            const SizedBox(height: 30),
            // Save Button
            ElevatedButton.icon(
              onPressed: () async {
                await profileController.updateProfile(
                  imagePath.value,
                  nameController.text,
                  aboutController.text,
                  profileController.currentUser.value.phoneNumber ?? "",
                );
                Get.back(); // Navigate back to ProfilePage
              },
              icon: const Icon(Icons.save),
              label: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
