class Item {
  final int _id;
  final String _status;
  final double _temperature;
  final String _location;

  Item(this._id, this._status, this._temperature, this._location);

  String getStatus() => _status;
  int getId() => _id;
  double getTemperature() => _temperature;
  String getLocation() => _location;
}