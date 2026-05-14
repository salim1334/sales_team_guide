import 'package:alarm_sales_guide/data/local/db_helper.dart';

class OnboardingService {
  static const _key = 'hasSeenOnboarding';

  Future<bool> hasSeen() async {
    final value = await DatabaseHelper.instance.getSetting(_key);
    return value == 'true';
  }

  Future<void> setSeen() async {
    await DatabaseHelper.instance.updateSetting(_key, 'true');
  }
}
