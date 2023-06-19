class Item {
  final int _id;
  final String _status;
  final double _temperatureC;
  final double _temperatureF;
  final String _location;
  final String _country;
  final String _localTime;
  final String _lastUpdate;

  Item(this._id, this._status, this._temperatureC,
      this._temperatureF, this._location,
      this._country, this._localTime, this._lastUpdate);

  String getStatus() => _status;
  int getId() => _id;
  double getTemperatureC() => _temperatureC;
  double getTemperatureF() => _temperatureF;
  String getLocation() => _location;
  String getCountry() => _country;
  String getLocalTime() => _localTime;
  String getLastUpdate() => _lastUpdate;
}