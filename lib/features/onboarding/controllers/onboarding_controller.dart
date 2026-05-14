import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final RxInt stepIndex = 0.obs;

  void next() {
    stepIndex.value++;
  }

  void back() {
    if (stepIndex.value > 0) {
      stepIndex.value--;
    }
  }

  void reset() {
    stepIndex.value = 0;
  }
}
