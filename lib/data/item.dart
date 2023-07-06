// ignore_for_file: avoid_print

import 'package:untitled/utils/generate_id.dart';

class Item {
  late int _id;
  final String _status;
  final double _temperatureC;
  final double _temperatureF;
  final String _location;
  final String _country;
  final String _localTime;
  final String _lastUpdate;
  late String _imgID;

  Item(this._status, this._temperatureC, this._temperatureF,
      this._location, this._country, this._localTime, this._lastUpdate) {
    _id = generateID();
    _imgID = generateRandomFromId(_id.toString());
    print('create item $_id and img $_imgID');
  }

  String getStatus() => _status;
  int getId() => _id;
  double getTemperatureC() => _temperatureC;
  double getTemperatureF() => _temperatureF;
  String getLocation() => _location;
  String getCountry() => _country;
  String getLocalTime() => _localTime;
  String getLastUpdate() => _lastUpdate;
  String getImgID() => _imgID;
}
