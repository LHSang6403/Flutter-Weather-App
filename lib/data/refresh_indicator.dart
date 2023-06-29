import 'package:untitled/data/items.dart';

class RefreshData {
  List<String> needRefreshCities = [];

  void loadToNeedRefreshCities(String location) {
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
