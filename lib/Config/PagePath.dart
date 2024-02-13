import 'package:get/get.dart';
import 'package:sampark/Pages/Auth/AuthPage.dart';
import 'package:sampark/Pages/Chat/ChatPage.dart';
import 'package:sampark/Pages/Home/HomePage.dart';
import 'package:sampark/Pages/UserProfile/ProfilePage.dart';

import '../Pages/UserProfile/UpdateProfile.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
    page: () => AuthPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: () => HomePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/chatPage",
    page: () => ChatPage(),
    transition: Transition.rightToLeft,
  ),
  // GetPage(
  //   name: "/profilePage",
  //   page: () => UserProfilePage(),
  //   transition: Transition.rightToLeft,
  // ),
  // GetPage(
  //   name: "/updateProfilePage",
  //   page: () => UserUpdateProfile(),
  //   transition: Transition.rightToLeft,
  // ),

  
];
