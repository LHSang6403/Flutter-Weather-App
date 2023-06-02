import 'package:get/get.dart';

class ViewModeController extends GetxController {
  //Theme options
  int currentIndex = 0;
  RxInt indexThemeData = 0.obs;

  //View options
  List<String> viewModes = ['List view', 'Grid view'];
  RxInt viewModesCurrentIndex = 0.obs;

  void changeTheme(int value) {
    indexThemeData.value = value;
    currentIndex = value;
  }

  void changeView(int value) {
    viewModesCurrentIndex.value = value;
  }
}
