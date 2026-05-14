import 'package:alarm_sales_guide/features/admin/screens/admin_login/admin_login.dart';
import 'package:alarm_sales_guide/features/admin/screens/admin_sign_up/admin_sign_up.dart';
import 'package:alarm_sales_guide/features/admin/screens/dashboard/dashboard.dart';
import 'package:alarm_sales_guide/features/onboarding/screens/onboarding_screen.dart';
import 'package:alarm_sales_guide/features/sales_team/screens/ad_templates/ad_templates.dart';
import 'package:alarm_sales_guide/features/sales_team/screens/call_guide/call_guide.dart';
import 'package:alarm_sales_guide/features/sales_team/screens/settings/settings.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.adminLogin, page: () => AdminLoginScreen()),
    GetPage(name: AppRoutes.adminSignUp, page: () => AdminSignUpScreen()),
    GetPage(name: AppRoutes.adminDashboard, page: () => AdminDashboard()),
    GetPage(name: AppRoutes.settings, page: () => Settings()),
    GetPage(name: AppRoutes.callGuide, page: () => CallGuide()),
    GetPage(name: AppRoutes.adTemplate, page: () => AdTemplates()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
  ];
}
