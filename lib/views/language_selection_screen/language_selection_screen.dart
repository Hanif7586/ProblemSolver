import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/color.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final Map<String, Map<String, dynamic>> languages = {
    'বাংলা': {
      'locale': const Locale('bn', 'BD'),
      'icon': Icons.language,
    },
    'English': {
      'locale': const Locale('en', 'US'),
      'icon': Icons.language,
    },
    'हिन्दी': {
      'locale': const Locale('hi', 'IN'),
      'icon': Icons.language,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          'select_language'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
               child: Text(
                'Please select your language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                           ),
             ),
            const SizedBox(height: 16),
            ...languages.entries.map((entry) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: ListTile(
                  leading: Icon(entry.value['icon'], color: primaryColor),
                  title: Text(
                    entry.key,
                    style: const TextStyle(fontSize: 20),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    final selectedLocale = entry.value['locale'];
                    final box = GetStorage();

                    // Save selected locale
                    box.write('selectedLocale', {
                      'languageCode': selectedLocale.languageCode,
                      'countryCode': selectedLocale.countryCode,
                    });

                    Get.updateLocale(selectedLocale);
                    Get.off(() => BottomNavBar());
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
