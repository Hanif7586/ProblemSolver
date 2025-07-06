
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/color.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: allbackgroundcolor,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomText(
              text: 'forgot_password'.tr,
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: Colors.black87,
            ),
            CustomText(
              text: 'forgot_instruction'.tr,
              fontWeight: FontWeight.w300,
              fontSize: 19,
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'enter_email'.tr,
              icon: Icons.email,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'reset_password'.tr,
              backgroundColor: primaryColor,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
