import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

List<String> suggestionList = [];

void parseCities(dynamic parsedJson) {
  final citiesJson = parsedJson as List<dynamic>;

  for (final cityJson in citiesJson) {
    final String name = cityJson['name'] as String;
    final String country = cityJson['country'] as String;
    suggestionList.add(name);
    suggestionList.add(country);
  }
}

Future<void> loadJsonCities() async {
  final String jsonString = await rootBundle.loadString('assets/cities.json');
  final data = jsonDecode(jsonString);
  parseCities(data);
}

class SearchPage extends StatefulWidget {
  final Function addCard;
  SearchPage({Key? key, required this.addCard});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void initState() {
    super.initState();
    loadJsonCities();
  }

  var _suggestionController = new TextEditingController();
  String locationRequest = '';
  final fieldText = TextEditingController();
  _SearchPageState({Key? key});

  void _handleOnCLick() {
    if (locationRequest.isEmpty) {
      return;
    }
    widget.addCard(locationRequest);
    fieldText.clear();
    loadJsonCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: <Widget>[
              AutoCompleteTextField(
                controller: _suggestionController,
                suggestions: suggestionList,
                //clearOnSubmit: true,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
                itemFilter: (item, query) {
                  if (item != null) {
                    return item
                        .toString()
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  } else {
                    return false;
                  }
                },
                itemSorter: (a, b) {
                  if (a != null && b != null) {
                    return a.toString().compareTo(b.toString());
                  } else {
                    return 0;
                  }
                },
                itemSubmitted: (item) {
                  locationRequest = item.toString();
                  _suggestionController.text = item.toString();
                  print("item-click");
                  _handleOnCLick();
                },
                itemBuilder: (context, item) {
                  return Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.toString(),
                            style: const TextStyle(color: Colors.black),
                          )
                        ],
                      ));
                },
                key: GlobalKey(),
              ),
            ],
          ),
        )
        //----
        // body: Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 14.0, left: 18.0, bottom: 14.0),
        //       child: SizedBox(
        //         height: 60,
        //         width: 300,
        //         child: TextField(
        //           onChanged: (text) {
        //             locationRequest = text;
        //           },
        //           decoration: const InputDecoration(
        //             labelText: 'Search',
        //             border: OutlineInputBorder(),
        //           ),
        //           controller: fieldText,
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 14.0, left: 14.0, bottom: 14.0),
        //       child: SizedBox(
        //         height: 60,
        //         width: 80,
        //         child: ElevatedButton(
        //           onPressed: () => _handleOnCLick(),
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.white,
        //             // Background color
        //           ),
        //           child: const Text(
        //             'Add',
        //             style: TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        );
  }
}
