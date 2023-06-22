import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:get/get.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/dialogs/loading_dialog.dart';
import 'package:untitled/pages/search_page/search_page_controller.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';

List<String> suggestionList = [];
final VoiceController voiceController = Get.find();
final ViewModeController viewModeController = Get.find();
final suggestionController = TextEditingController();
final fieldText = TextEditingController();

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
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  void initState() {
    super.initState();
    loadJsonCities();
  }

  String locationRequest = '';
  SearchPageState({Key? key});

  void handleOnCLick() {
    if (locationRequest.isEmpty) {
      return;
    }
    widget.addCard(locationRequest);
    refreshData.loadToNeedRefreshCities(locationRequest);
    fieldText.clear();
    loadJsonCities();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Obx(() => Scaffold(
            backgroundColor: Colors.white.withOpacity(0.0),
            appBar: AppBar(
              title: Text(
                'Search',
                style: TextStyle(
                    color: themeData.getSelectedButtonColor(
                        viewModeController.indexThemeData.value),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: themeData
                  .getPrimaryColor(viewModeController.indexThemeData.value),
            ),
            body: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  AutoCompleteTextField(
                    controller: suggestionController,
                    suggestions: suggestionList,
                    //clearOnSubmit: true,
                    cursorColor: themeData.getAccentColor(
                        viewModeController.indexThemeData.value),
                    style: TextStyle(
                        color: themeData.getAccentColor(
                            viewModeController.indexThemeData.value),
                        fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                              color: themeData.getAccentColor(
                                  viewModeController.indexThemeData.value),
                              width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
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
                      suggestionController.text = item.toString();
                      handleOnCLick();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          context = context;
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                          });
                          return const Loading();
                        },
                      );
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
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: FloatingActionButton(
                onPressed: voiceController.speechToText!.isNotListening
                    ? voiceController.startListening
                    : voiceController.stopListening,
                tooltip: 'Listen',
                backgroundColor: themeData
                    .getPrimaryColor(viewModeController.indexThemeData.value),
                child: Icon(
                  Icons.mic_outlined,
                  color: themeData
                      .getSelectedButtonColor(viewModeController.indexThemeData.value),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          )),
    );
  }
}
