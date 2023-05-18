class Item{
  final int _id;
  final String _status;
  final double _temperature;
  final String _address;

  Item(this._id, this._status, this._temperature, this._address);
  String getName() => _status;
  int getId() => _id;
  double getTemperature() => _temperature;
  String getAddress() => _address;
}