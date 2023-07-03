import 'package:get/get.dart';
import '../ui/screens/profile/edit_profile.dart';
import '../ui/screens/auth/login.dart';
import '../ui/screens/auth/signup.dart';
import '../ui/screens/home/main.dart';
import '../ui/screens/initial.dart';

class AppRoutes {
  static final routes = [
    GetPage(
        name: "/",
        page: () => const Initial(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(seconds: 2)),
    GetPage(
      name: "/login",
      page: () => const Login(),
      transition: Transition.zoom,
    ),
    GetPage(
        name: "/register",
        page: () => const Signup(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(seconds: 2)),
    GetPage(
        name: "/homeMain",
        page: () => HomeMain(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(seconds: 2)),
    GetPage(
        name: "/edit_profile",
        page: () => EditProfileScreen(),
        transition: Transition.cupertinoDialog,
        transitionDuration: const Duration(seconds: 2)),
  ];
}
