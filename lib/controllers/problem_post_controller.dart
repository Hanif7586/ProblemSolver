import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/api_service.dart';


class ProblemPostController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File? selectedImage;

  RxBool isLoading = false.obs;

  Future<void> submitProblem({
    required String token,
    required String userId,
  }) async {
    try {
      isLoading.value = true;

      final response = await ApiService.postProblem(
        token: token,
        userId: userId,
        title: titleController.text,
        content: contentController.text,
        imageFile: selectedImage,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Problem posted successfully');
        titleController.clear();
        contentController.clear();
        selectedImage = null;
      } else {
        Get.snackbar('Error', 'Failed to post problem');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
