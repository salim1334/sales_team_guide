import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alarm_sales_guide/routes/routes.dart';
import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/text_strings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:alarm_sales_guide/common/widgets/app_bar/custom_app_bar.dart';

class NavigationDrawerLayout extends StatelessWidget {
  const NavigationDrawerLayout({
    super.key,
    required this.body,
    required this.title,
    this.actions,
  });

  final Widget body;
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentRoute = Get.currentRoute;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final selectedIndex = _routeToIndex(currentRoute);

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: title,
        leadingIcon: Icons.menu,
        onLeadingIconPressed: () => scaffoldKey.currentState?.openDrawer(),
        actions: actions,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.adminLogin);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      size: 32,
                      color: isDark ? AppColors.onPrimary : AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppTexts.appName,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.phone_in_talk_outlined,
              title: AppTexts.liveCallGuide,
              route: AppRoutes.callGuide,
              currentRoute: currentRoute,
            ),
            _buildDrawerItem(
              context,
              icon: Iconsax.document_copy,
              title: AppTexts.adTemplates,
              route: AppRoutes.adTemplate,
              currentRoute: currentRoute,
            ),
            // ── Audio Library ───────────────────────────────────
            _buildDrawerItem(
              context,
              icon: Iconsax.music,
              title: AppTexts.audioLibrary,
              route: AppRoutes.audioLibrary,
              currentRoute: currentRoute,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings_outlined,
              title: AppTexts.settings,
              route: AppRoutes.settings,
              currentRoute: currentRoute,
            ),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          final route = _indexToRoute(index);
          if (route != currentRoute) Get.offAllNamed(route);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.phone_in_talk_outlined),
            label: AppTexts.liveCallGuide,
          ),
          NavigationDestination(
            icon: Icon(Iconsax.document_copy),
            label: AppTexts.adTemplates,
          ),
          NavigationDestination(
            icon: Icon(Iconsax.music),
            label: AppTexts.audioLibrary,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: AppTexts.settings,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required String currentRoute,
  }) {
    final isSelected = currentRoute == route;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.secondaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? colorScheme.onSecondaryContainer
              : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? colorScheme.onSecondaryContainer
                : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        onTap: () {
          Get.back();
          if (!isSelected) Get.offAllNamed(route);
        },
      ),
    );
  }

  int _routeToIndex(String route) {
    switch (route) {
      case AppRoutes.adTemplate:
        return 1;
      case AppRoutes.audioLibrary:
        return 2;
      case AppRoutes.settings:
        return 3;
      case AppRoutes.callGuide:
      default:
        return 0;
    }
  }

  String _indexToRoute(int index) {
    switch (index) {
      case 1:
        return AppRoutes.adTemplate;
      case 2:
        return AppRoutes.audioLibrary;
      case 3:
        return AppRoutes.settings;
      case 0:
      default:
        return AppRoutes.callGuide;
    }
  }
}
