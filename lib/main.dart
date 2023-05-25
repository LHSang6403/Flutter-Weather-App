import 'theme/theme_loader.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'widgets/card_body.dart';
import 'widgets/card_input.dart';
import 'data/items.dart';
//import 'widgets/bottom_bar.dart';

ThemeDataModel themeData = ThemeDataModel();

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
  @override
  void initState() {
    super.initState();
    //ThemeDataModel tmp = ThemeDataModel();
    loadJsonAsset();
  }

  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/themes.json');
    final data = jsonDecode(jsonString);

    themeData.parseThemes(data);
    //print(themeData.listThemes);
    //print(themeData.listThemes[0].primaryColor);
    print(convertHexToColor(themeData.listThemes[1].primaryColor));
    //print(themeData.listThemes[1].name);
  }

  Data weatherData = Data();
  void _handleAddCard(String locationName) async {
    await weatherData.dataHandleAdd(locationName);
    setState(() {});
  }

  void _handleDeleteCard(int id) {
    weatherData.items.removeWhere((item) => id == item.getId());
    setState(() {});
  }

  void toggleTheme() {
    //print(currentTheme);
    // setState(() {
    //   if (currentTheme == ThemeData.light()) {
    //     currentTheme = ThemeData.dark();
    //   } else {
    //     currentTheme = ThemeData.light();
    //   }
    // });
  }

  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Perform additional actions based on the selected tab
    switch (index) {
      case 0:
        break;
      case 1:
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (BuildContext content) {
            // context means the position where we want to show this modal -> MyApp
            return CardInput(addCard: _handleAddCard);
          },
        );
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(themeData.listThemes[0].primaryColor);
    return MaterialApp(
      //theme: Color(convertHexToInt(themeData.listThemes[0].primaryColor)),
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Weather Api App',
              style: TextStyle(fontSize: 30),
            ),
            backgroundColor: (themeData.listThemes.isNotEmpty)
                ? convertHexToColor(themeData.listThemes[1].primaryColor)
                : (Colors.red)), // can not read themeData
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: weatherData.items
                .map((item) => CardBody(
                      item: item,
                      deleteCard: _handleDeleteCard,
                      parentContext: context,
                    ))
                .toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: Colors.blue,
          selectedFontSize: 12,
          selectedIconTheme:
              const IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
