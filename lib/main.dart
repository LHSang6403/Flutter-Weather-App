import 'theme/theme_loader.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'widgets/card_body.dart';
import 'widgets/card_input.dart';
import 'data/items.dart';

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

    ThemeDataModel themeData = ThemeDataModel();
    themeData.parseThemes(data);
    //print(themeData.listThemes[0].name);
    //print(themeData.listThemes[1].name);
  }

  ThemeData currentTheme = ThemeData.light();

  final modifiedTheme = ThemeData.light().copyWith(
    // Customize properties of the theme
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.red, // Change the primaryColor
          secondary: Colors.blue, // Change the secondaryColor
        ),
  );

  Data weatherData = Data();
  void _handleAddCard(String locationName) async {
    //print('setState, re-render');
    await weatherData.dataHandleAdd(locationName);
    setState(() {});
  }

  void _handleDeleteCard(int id) {
    weatherData.items.removeWhere((item) => id == item.getId());
    //print('setState, re-render');
    setState(() {});
  }

  void toggleTheme() {
    //print(currentTheme);
    setState(() {
      if (currentTheme == ThemeData.light()) {
        currentTheme = ThemeData.dark();
      } else {
        currentTheme = ThemeData.light();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: currentTheme,
      home: Theme(
        data: currentTheme,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Weather Api App',
              style: TextStyle(fontSize: 30),
            ),
          ),
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
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (BuildContext content) {
                        // context means the position where we want to show this modal -> MyApp
                        return CardInput(addCard: _handleAddCard);
                      },
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 42,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    toggleTheme();
                  },
                  child: const Icon(
                    Icons.light_mode,
                    //Icons.dark_mode,
                    size: 42,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
