import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:homeworkhelper/views/auth/login_view/login_view.dart';
import '../controllers/navigation_controller.dart';
import '../views/auth/profile/profile.dart';
import '../views/auth/register_view/register_view.dart';
import '../views/home_view/home_view.dart';
import '../views/problem_post_view/problem_post_view.dart';
import 'color.dart';

class BottomNavBar extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());
  late final List<Widget> pages;

  BottomNavBar({Key? key}) : super(key: key) {
    pages = [
       HomeView(),
      ProblemPostView(),
      ProfileView(),
      LoginView(),
     // Replace with ProfileView if available
    ];
  }

  Future<bool> _onWillPop() async {
    if (navController.currentIndex.value != 0) {
      navController.changePage(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenHeight * 0.01;
    final double iconSize = screenWidth * 0.06;
    final double gap = screenWidth * 0.02;
    final double fontSize = screenWidth * 0.035;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(() => pages[navController.currentIndex.value]),
        bottomNavigationBar: Obx(() {
          return Container(
            height: screenHeight * 0.09,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: GNav(
                gap: gap,
                activeColor: Colors.white,
                color: Colors.grey,
                iconSize: iconSize,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: primaryColor,
                tabBorderRadius: 12,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'home'.tr,
                    textStyle: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                  GButton(
                    icon: Icons.post_add,
                    text: 'post'.tr,
                    textStyle: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'profile'.tr,
                    textStyle: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                  GButton(
                    icon: Icons.account_box,
                    text: 'account'.tr,
                    textStyle: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                ],

                selectedIndex: navController.currentIndex.value,
                onTabChange: (index) {
                  navController.changePage(index);
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}