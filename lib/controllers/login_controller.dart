import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart'; // <-- এটি যোগ করুন
import 'package:homeworkhelper/models/login_model.dart';

import '../core/services/api_service.dart';
import '../widgets/bottom_nav_bar.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var user = Rxn<Login>();
  var token = ''.obs;

  final box = GetStorage();  // <-- GetStorage ইনস্ট্যান্স

  @override
  void onInit() {
    super.onInit();
    loadUserFromStorage();
  }

  void loadUserFromStorage() {
    final savedToken = box.read('token');
    final savedUser = box.read('user');

    if (savedToken != null && savedUser != null) {
      token.value = savedToken;
      user.value = Login.fromJson(Map<String, dynamic>.from(savedUser));
    }
  }

  Future<void> loginUser() async {
    isLoading.value = true;
    final response = await ApiService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;

    if (response != null) {
      user.value = response.user;
      token.value = response.token;

      // ====== লোকালি সেভ করুন ======
      box.write('token', token.value);
      box.write('user', response.user!.toJson());

      Get.off(() => BottomNavBar());
    } else {
      Get.snackbar("Error", "Login failed. Check credentials.");
    }
  }

  void logout() {
    box.erase();
    user.value = null;
    token.value = '';
    Get.offAllNamed('/login'); // অথবা লগইন স্ক্রীনে নেভিগেট করুন
  }
}
