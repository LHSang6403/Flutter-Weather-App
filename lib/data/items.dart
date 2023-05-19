import 'package:http/http.dart' as http;
import 'dart:convert';
import 'generate_id.dart';

class Item {
  final int _id;
  final String _status;
  final double _temperature;
  final String _address;

  Item(this._id, this._status, this._temperature, this._address);

  String getStatus() => _status;
  int getId() => _id;
  double getTemperature() => _temperature;
  String getAddress() => _address;
}

class Data {
  List<Item> items = [];

  Data() {
    items = [];
  }

  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    String apiKey =
        '35e9d955b0c34e0c81a35131231905'; // Replace with your actual API key
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  void dataHandleAdd(String location) async {
    try {
      final weatherData = await fetchWeatherData(location);
      final tempC = weatherData['current']['temp_c'];
      final condition = weatherData['current']['condition']['text'];

      //print('Weather:');
      //print('Temp C: $tempC');
      //print('Condition: $condition');

      var item = Item(getCurrentDateAsInt(), condition, tempC, location);
      items.add(item);
      PrintOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  void PrintOut() {
    print('List:');
    items.forEach((item) {
      print(item.getId());
      print(item.getStatus());
      print(item.getTemperature());
      print(item.getAddress());
      print('--');
    });
    print('\n');
  }
}

void main() {
  Data temp = Data();

  temp.dataHandleAdd('Hanoi');
  temp.dataHandleAdd('New York');
  temp.dataHandleAdd('Paris');
  temp.dataHandleAdd('San Jose');
}
