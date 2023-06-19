import 'package:get/get.dart';

class ViewModeController extends GetxController {
  int currentIndex = 0;
  RxInt indexThemeData = 0.obs;

  List<String> viewModes = ['List view', 'Grid view'];
  RxInt viewModesCurrentIndex = 0.obs;
  RxBool isGrid = false.obs;

  void changeTheme(int value) {
    indexThemeData.value = value;
    currentIndex = value;
  }

  void changeView(int value) {
    viewModesCurrentIndex.value = value;
  }

  void toggleChangeView(bool value) {
    if (isGrid.value == false && value == true) {
      isGrid.value = value;
      viewModesCurrentIndex.value = 1;
    } else if (isGrid.value == true && value == false) {
      isGrid.value = value;
      viewModesCurrentIndex.value = 0;
    } else {
      print("Toggle error");
    }
  }
}
