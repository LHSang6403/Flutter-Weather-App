import 'package:http/http.dart' as http;
import 'dart:convert';
import 'items.dart';
import 'generate_id.dart';

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

void handleFetch(String location) async {
  try {
    final weatherData = await fetchWeatherData(location);
    //print(weatherData);

    final temp_c = weatherData['current']['temp_c'];
    //final temp_f = weatherData['current']['temp_f']; // not used now
    final condition = weatherData['current']['condition']['text'];
    //final localtime = weatherData['location']['localtime']; // not used now

    print('Weather:');
    print('Temp C: $temp_c');
    //print('Temp F: $temp_f');
    print('Condition: $condition');
    //print('Local Time: $localtime');

    var item = Item(getCurrentDateAsInt(), condition, temp_c, location);
  } catch (e) {
    print('Error: $e');
  }
}
