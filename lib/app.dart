import 'package:alarm_sales_guide/bindings/general_bindings.dart';
import 'package:alarm_sales_guide/routes/app_routes.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Sales Guide',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBindings(),
      initialRoute: AppRoutes.adTemplate,
      getPages: AppRoute.pages,
    );
  }
}
