import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/features/admin/controllers/auth_controller.dart';
import 'package:alarm_sales_guide/utils/constants/sizes.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/common/widgets/buttons/primary_button.dart';
import 'package:alarm_sales_guide/common/widgets/text_fields/custom_text_field.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and Header in a Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                  side: BorderSide(color: colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.xl),
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo box
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(Icons.security, size: 32, color: colorScheme.onPrimary),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        // Title
                        Text(
                          AppTexts.appName,
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 28,
                                color: colorScheme.onSurface,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.xs),
                        Text(
                          AppTexts.appSubtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Form Fields
                        CustomTextField(
                          controller: controller.emailController,
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Email is required' : null,
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        
                        Obx(
                          () => CustomTextField(
                            controller: controller.passwordController,
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            obscureText: !controller.isPasswordVisible.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'Password is required' : null,
                          ),
                        ),
                        const SizedBox(height: AppSizes.sm),

                        // Remember Me and Forgot Password
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 320;
                            final rememberRow = Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: controller.toggleRememberMe,
                                    activeColor: colorScheme.primary,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Remember me for 30 days',
                                    style: Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );

                            final forgotButton = TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colorScheme.primary),
                              ),
                            );

                            if (isNarrow) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  rememberRow,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: forgotButton,
                                  ),
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: rememberRow),
                                forgotButton,
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        // Login Button
                        Obx(
                          () => PrimaryButton(
                            text: AppTexts.secureLogin,
                            icon: Icons.login,
                            isLoading: controller.isLoading.value,
                            onPressed: () => controller.login(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwItems),
              
              // Create Account Link
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Need administrative access?', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.adminSignUp),
                    child: Text(
                      AppTexts.createAdminAccount,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: colorScheme.secondary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),
              
              // System Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Text(
                      AppTexts.systemStatus,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
