import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkhelper/widgets/color.dart';
import 'package:homeworkhelper/widgets/custom_app_bar.dart';
import '../../../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (controller.token.value.isNotEmpty && controller.user.value != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.blueAccent),
                  SizedBox(height: 10),
                  Text(
                    'Logged in as ${controller.user.value!.name ?? "User"}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: controller.logout,
                    icon: Icon(Icons.logout,color: Colors.white,),
                    label: Text('Logout',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800
                    ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.lock, size: 80, color: primaryColor),
                  SizedBox(height: 30),
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton.icon(
                    onPressed: controller.loginUser,
                    icon: Icon(Icons.login,color: Colors.white,),
                    label: Text("Login",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800
                    ),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
