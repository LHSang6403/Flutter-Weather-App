import 'package:flutter/material.dart';
import 'widgets/card_body.dart';
import 'widgets/card_input.dart';
import 'data/items.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Item> items = [
    Item(1, 'Sunny', 30.0, 'HCM'),
    Item(2, 'Rainy', 25.5, 'HN'),
    Item(3, 'Cloudy', 28.5, 'DN'),
  ];

  int getCurrentDateAsInt() {
    DateTime now = DateTime.now();
    int currentDate = int.parse("${now.year}${now.month}${now.day}");
    return currentDate;
  }

  void _handleAddCard(String locationName) {
    // call api to get: status, temperature
    int idAdd = getCurrentDateAsInt();
    String statusAdd = 'unknow'; // api
    double temperatureAdd = 0; // api
    String locationAdd = locationName;

    var tempItem = Item(idAdd, statusAdd, temperatureAdd, locationAdd);
    setState(() {
      //re-render _MyAppState when it has a change of this func add items
      items.add(tempItem);
    });
  }

  void _handleDeleteCard(int id) {
    setState(() {
      items.removeWhere((item) => id == item.getId());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Api App',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: items
              .map((item) => CardBody(
                    item: item,
                    deleteCard: _handleDeleteCard,
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print('click');
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
    );
  }
}
