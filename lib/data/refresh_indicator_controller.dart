import 'package:get/get.dart';
import 'package:untitled/data/items.dart';

class RefreshController extends GetxController {
  Rx<Data> weatherData = Data().obs;
}