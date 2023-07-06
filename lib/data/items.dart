// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'item.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Data {
  List<Item> items = [];

  Data() {
    items = [];
  }

  Future<Map<String, dynamic>> fetchWeatherData(String location) async {
    await dotenv.load(fileName: 'assets/.env');
    String apiKey = dotenv.env['API_KEY'] ?? '';
    String apiUrl = dotenv.env['API_URL'] ?? '';

    final url = '$apiUrl=$apiKey&q=$location';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<void> dataHandleAdd(String location) async {
    try {
      final weatherData = await fetchWeatherData(location);
      final tempC = weatherData['current']['temp_c'];
      final tempF = weatherData['current']['temp_f'];
      final condition = weatherData['current']['condition']['text'];
      final country = weatherData['location']['country'];
      final localTime = weatherData['location']['localtime'];
      final lastUpdate = weatherData['current']['last_updated'];

      var item = Item(
          condition, tempC, tempF, location, country, localTime, lastUpdate);
      items.add(item);
    } catch (e) {
      print('Error: $e');
    }
  }

  void add100Items() {
    // for ui testing
    for (var i = 0; i < 100; i++) {
      var item = Item('conditionnnnnnnnnnnnnnnn', 37, 67, 'location', 'country',
          'localTime', 'lastUpdate');
      items.add(item);
    }
  }

  void printOut() {
    print('-----');
    print('Lasted List:');
    for (var item in items) {
      print(item.getId());
      print(item.getStatus());
      print(item.getTemperatureC());
      print(item.getTemperatureF());
      print(item.getLocation());
      print(item.getCountry());
      print(item.getLocalTime());
      print(item.getLastUpdate());
    }
    print('-----');
  }
}
