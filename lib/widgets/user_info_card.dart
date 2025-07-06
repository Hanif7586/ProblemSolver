import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import 'color.dart';

class UserInfoCard extends StatelessWidget {
  static final LoginController _controller = Get.find();

  // Static getters to access userId and token
  static String? get userId => _controller.user.value?.id?.toString();
  static String? get token => _controller.token.value;

  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _controller.user.value;
    final tokenValue = _controller.token.value;

    if (user == null) {
      return Center(child: Text("No user data available"));
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem(Icons.badge, 'User ID', user.id?.toString()),
            const SizedBox(height: 10),
            _buildItem(Icons.lock, 'Token', tokenValue),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        const SizedBox(width: 10),
        Text(
          "$label: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value ?? 'Not available',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
