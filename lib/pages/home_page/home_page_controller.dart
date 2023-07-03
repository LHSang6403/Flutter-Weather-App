import 'package:get/get.dart';

class SliderController extends GetxController {
  RxInt currentIndexSlider = 0.obs;
  int widgetsNumber = 4;

  void slide() {
    if (currentIndexSlider.value == widgetsNumber - 1) {
      currentIndexSlider.value = 0;
    } else {
      currentIndexSlider.value++;
    }
  }

  int getValue(){
    return currentIndexSlider.value;
  }
}
