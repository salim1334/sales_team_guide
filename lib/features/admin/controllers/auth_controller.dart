import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/helpers/helper_functions.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  // TextField Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Observables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final user = await DatabaseHelper.instance.authenticateUser(
        emailController.text.trim(),
        passwordController.text,
      );

      if (user != null) {
        // Success
        Get.offAllNamed(AppRoutes.adminDashboard);
      } else {
        // Failed
        THelperFunctions.showSnackBar('Login Failed', 'Invalid email or password', isError: true);
      }
    } catch (e) {
      THelperFunctions.showSnackBar('Error', 'An error occurred during login', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void clearSessionState() {
    emailController.clear();
    passwordController.clear();
    rememberMe.value = false;
    isPasswordVisible.value = false;
    isLoading.value = false;
  }

  void logout() {
    clearSessionState();
    Get.offAllNamed(AppRoutes.adminLogin);
  }
}
