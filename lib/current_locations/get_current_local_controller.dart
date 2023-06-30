import 'package:get/get.dart';
import 'package:untitled/current_locations/get_current_local.dart';
import 'package:untitled/data/items.dart';

class CurrentLocationController extends GetxController {
  RxList<String> currentLocals = ['Ho Chi Minh City'].obs;
  Rx<Data> currentLocaltionsWeatherData = Data().obs;

  CurrentLocationController();

  Future updateCurrentLocal() async {
    Future<List<String>> currentLocalLists = getCurrentPlacemark();
    currentLocalLists.then((List<String> localList) async {
      for (var i = 0; i < 3; i++) {
        String? tmpLocal = localList[i];
        currentLocals.add(tmpLocal);
        //print(localList[i]);
      }

      Data temp = Data();
      for (String city in currentLocals) {
        //print('City: $city');
        await temp.dataHandleAdd(city);
      }
      //temp.PrintOut();
      currentLocaltionsWeatherData.value = temp;
    });
  }

  List<String> getCurrentLocals() {
    return currentLocals;
  }
}
