import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/data/local/db_helper.dart';

class SettingsController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final RxString fontScale = 'medium'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final themeStr = await DatabaseHelper.instance.getSetting('themeMode');
    if (themeStr != null) {
      if (themeStr == 'light') {
        themeMode.value = ThemeMode.light;
      } else if (themeStr == 'dark') {
        themeMode.value = ThemeMode.dark;
      } else {
        themeMode.value = ThemeMode.system;
      }
    }

    final fontStr = await DatabaseHelper.instance.getSetting('fontScale');
    if (fontStr != null) {
      fontScale.value = fontStr;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    String modeStr = 'system';
    if (mode == ThemeMode.light) {
      modeStr = 'light';
    }
    if (mode == ThemeMode.dark) {
      modeStr = 'dark';
    }
    await DatabaseHelper.instance.updateSetting('themeMode', modeStr);
  }

  Future<void> setFontScale(String scale) async {
    fontScale.value = scale;
    await DatabaseHelper.instance.updateSetting('fontScale', scale);
    // Note: To fully apply font scaling, AppTheme would need to dynamically rebuild
    Get.snackbar('Font Applied', 'Font scale changed to $scale.', snackPosition: SnackPosition.BOTTOM);
  }
}
