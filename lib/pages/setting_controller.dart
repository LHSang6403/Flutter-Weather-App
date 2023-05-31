import 'package:get/get.dart';

class ViewModeController extends GetxController {
  int currentIndex = 0;
  RxInt indexThemeData = 0.obs;

  void increaseTheme() {
    indexThemeData.value++;
    currentIndex++;
  }

  void changeTheme(int value) {
    indexThemeData.value = value;
    currentIndex = value;
  }
}
