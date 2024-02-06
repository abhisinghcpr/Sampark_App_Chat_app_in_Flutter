import 'package:get/get.dart';
import 'package:sampark/Pages/Auth/AuthPage.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
    page: () => AuthPage(),
    transition: Transition.rightToLeft,
  ),
];
