import 'package:alarm_sales_guide/bindings/general_bindings.dart';
import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/features/onboarding/services/onboarding_service.dart';
import 'package:alarm_sales_guide/routes/app_routes.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  final hasSeen = await Get.put(OnboardingService()).hasSeen();
  final initialRoute = hasSeen ? AppRoutes.adTemplate : AppRoutes.onboarding;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Sales Guide',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBindings(),

      initialRoute: initialRoute,
      getPages: AppRoute.pages,
    ),
  );
}
