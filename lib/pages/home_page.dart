import 'package:flutter/material.dart';
import 'package:untitled/data/items.dart';
import 'package:untitled/main.dart';
import 'package:untitled/theme/theme_loader.dart';
import 'package:untitled/widgets/card_body.dart';

class HomePage extends StatefulWidget {
  Data weatherData;
  HomePage({Key? key, required this.weatherData});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleDeleteCard(int id) {
    widget.weatherData.items.removeWhere((item) => id == item.getId());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: themeData.getPrimaryColor(indexThemeData),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: widget.weatherData.items
                .map((item) => CardBody(
                      item: item,
                      deleteCard: _handleDeleteCard,
                      parentContext: context,
                    ))
                .toList(),
          ),
        ));
  }
}
