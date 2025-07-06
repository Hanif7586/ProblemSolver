import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkhelper/widgets/color.dart';
import 'package:homeworkhelper/widgets/custom_app_bar.dart';
import '../../../controllers/login_controller.dart';

class ProfileView extends StatelessWidget {
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    return Scaffold(
      appBar: CustomAppBar(),
      body: user == null
          ? Center(
        child: Text(
          "No user data",
          style: TextStyle(fontSize: 18),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: primaryColor,
                  child: Text(
                    user.name != null && user.name!.isNotEmpty
                        ? user.name![0].toUpperCase()
                        : '?',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(),
                _buildProfileTile(Icons.person, 'Name', user.name),
                _buildProfileTile(Icons.email, 'Email', user.email),
                _buildProfileTile(Icons.phone, 'Phone', user.phone),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, dynamic value) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value?.toString() ?? 'Not available'),
    );
  }
}
