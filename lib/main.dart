import 'theme/theme_loader.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'data/items.dart';
import 'package:untitled/pages/search_page.dart';
import 'package:untitled/pages/setting_page.dart';
import 'package:untitled/pages/home_page.dart';

ThemeDataModel themeData = ThemeDataModel();
int indexThemeData = 0;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Data weatherData = Data();

  void initState() {
    super.initState();
    loadJsonAsset();

    _pages.add(HomePage(weatherData: weatherData));
    _pages.add(SearchPage(
      addCard: _handleAddCard,
    ));
    _pages.add(SettingsPage());
  }

  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/themes.json');
    final data = jsonDecode(jsonString);
    themeData.parseThemes(data);

    print(data);
  }

  void _handleAddCard(String locationName) async {
    await weatherData.dataHandleAdd(locationName);
    setState(() {});
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      //print(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: themeData.getPrimaryColor(indexThemeData),
          selectedFontSize: 10,
          selectedIconTheme: IconThemeData(
              color: themeData.getAccentColor(indexThemeData), size: 40),
          selectedItemColor: themeData.getAccentColor(indexThemeData),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.white70,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
