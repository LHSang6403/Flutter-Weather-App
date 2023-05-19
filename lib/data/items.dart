import 'package:http/http.dart' as http;
import 'dart:convert';
import 'generate_id.dart';

class Item {
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

final List<Item> items = [];

Future<void> fetchWeatherData(String location) async {
  String apiKey = '35e9d955b0c34e0c81a35131231905';
  final url =
      'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final tempC = data['current']['temp_c'];
    final condition = data['current']['condition']['text'];

    var item = Item(getCurrentDateAsInt(), condition, tempC, location);
    items.add(item);
  } else {
    throw Exception('Failed to fetch weather data');
  }
}

void handleFetch(String location) async {
  await fetchWeatherData(location);
}
// adding func just call handleFetch(location) to add new item with weather info to list

main() {
  handleFetch('London');
  handleFetch('Newyork');

  print(items);
}
