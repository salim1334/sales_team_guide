import 'package:alarm_sales_guide/data/local/db_helper.dart';
import 'package:alarm_sales_guide/features/audio/controllers/audio_player_controller.dart';
import 'package:alarm_sales_guide/features/audio/data/datasources/audio_seeder.dart';
import 'package:alarm_sales_guide/features/onboarding/services/onboarding_service.dart';
import 'package:alarm_sales_guide/routes/app_routes.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/bindings/general_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Open (and migrate) the single SQLite database.
  await DatabaseHelper.instance.database;

  // 2. Determine initial route (your existing onboarding logic — unchanged).
  final hasSeen = await Get.put(OnboardingService()).hasSeen();
  final initialRoute = hasSeen ? AppRoutes.adTemplate : AppRoutes.onboarding;

  // 3. Register the global audio player (permanent = survives route changes).
  Get.put(AudioPlayerController(), permanent: true);

  // 4. Seed initial audio tracks on first launch (no-op after that).
  await AudioSeeder.instance.seedIfNeeded();

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
