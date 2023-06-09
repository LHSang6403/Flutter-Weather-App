import 'package:get/get.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/data/items.dart';
import 'package:untitled/pages/home_page/home_page.dart';

class RefreshController extends GetxController {
  Rx<Data> weatherData = Data().obs;
  List<String> needRefreshCities = [];

  RefreshController() {
    weatherData.value.items = [];
  }

  void addCity(String location) async {
    await weatherData.value.dataHandleAdd(location);
    weatherData.refresh();
    loadToRefreshCities(location);
  }

  void removeCity(int id) {
    for (Item item in weatherData.value.items) {
      if (id == item.getId()) {
        refreshController.needRefreshCities.remove(item.getLocation());
      }
    }
    weatherData.value.items.removeWhere((item) => id == item.getId());
  }

  void loadToRefreshCities(String location) {
    needRefreshCities.add(location);
  }

  Future<Data?> handleRefresh() async {
    Data temp = Data();
    int i = 0;
    bool loadDone = false;

    for (String city in needRefreshCities) {
      await temp.dataHandleAdd(city);
      i++;
      if (i == needRefreshCities.length - 1) {
        loadDone = true;
      }
    }

    if (loadDone) return temp;
    return null;
  }
}
