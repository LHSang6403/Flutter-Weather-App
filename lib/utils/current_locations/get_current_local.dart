import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<Position> getCurrentLocation() async {
  await Geolocator.isLocationServiceEnabled();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<List<String>> getCurrentPlacemark() async {
  List<String> placeList = [];
  Position position = await getCurrentLocation();

  for (var i = 0; i < 3; i++) {
    List<Placemark> curLocal = await placemarkFromCoordinates(
        position.latitude + i * 2, position.longitude - i * 2);
    placeList.add(curLocal[0].country.toString());
  }

  return placeList;
}
