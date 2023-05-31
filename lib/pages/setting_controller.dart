import 'package:get/get.dart';

class ViewModeController extends GetxController {
  RxBool isDarkMode = false.obs; // do not use this
  RxInt indexThemeData = 0.obs;

  void increaseTheme() {
    //(indexThemeData == 0) ? indexThemeData = 1 : indexThemeData = 0;
    indexThemeData.value++;
  }
  void changeTheme(int value) {
    //(indexThemeData == 0) ? indexThemeData = 1 : indexThemeData = 0;
    indexThemeData.value = value;
  }
}
