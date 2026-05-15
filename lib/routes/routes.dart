// All App Screens
class AppRoutes {
  // Admin pages
  static const adminLogin = '/admin-login';
  static const adminSignUp = '/admin-signup';
  static const adminDashboard = '/admin-dashboard';
  static const audioManagement = '/audio-management'; // ← new

  // Sales team pages
  static const settings = '/settings';
  static const callGuide = '/call-guide';
  static const adTemplate = '/ad-templates';
  static const audioLibrary = '/audio-library'; // ← new
  static const onboarding = '/onboarding';

  static List<String> allAppScreenItems = [
    adminLogin,
    adminSignUp,
    adminDashboard,
    audioManagement,
    settings,
    callGuide,
    adTemplate,
    audioLibrary,
    onboarding,
  ];
}

