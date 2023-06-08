import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:get/get.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/setting_controller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
    _initSpeech();
  }

  final ViewModeController viewModeController = Get.find();
  final _suggestionController = TextEditingController();
  String locationRequest = '';
  final fieldText = TextEditingController();
  bool isFinalListen = false;

  _SearchPageState({Key? key});

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add location'),
          content: Text(
            'You mean add: $_lastWords',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () {
                widget.addCard(_lastWords);
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void showAddBottomSheet(BuildContext context, String locationName) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: themeData
              .getBackgroundColor(viewModeController.indexThemeData.value),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do you want to add: $locationName',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: viewModeController.indexThemeData.value == 0
                      ? Colors.black
                      : themeData.getAccentColor2(
                          viewModeController.indexThemeData.value),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.addCard(locationName);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeData.getSelectedButtonColor(
                          viewModeController.indexThemeData.value),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeData.getUnselectedButtonColor(
                          viewModeController.indexThemeData.value),
                      // Set the background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      // Set the padding
                      textStyle: const TextStyle(
                        fontSize: 16, // Set the font size
                        fontWeight: FontWeight.bold, // Set the font weight
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleOnCLick() {
    if (locationRequest.isEmpty) {
      return;
    }
    widget.addCard(locationRequest);
    fieldText.clear();
    loadJsonCities();
  }

// form herre
  SpeechToText? _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void _initSpeech() async {
    _speechToText!.initialize(onStatus: (status) {
      print(isFinalListen);
      if (status == 'done' && isFinalListen) {
        showAddBottomSheet(context, _lastWords);
        isFinalListen = false;
      }
    }).then((value) => _speechEnabled = value);
  }

  void _startListening() async {
    print('start listen');
    await _speechToText!.listen(onResult: _onSpeechResult, localeId: 'en_US');
    Timer(const Duration(seconds: 3), _stopListening);
  }

  void _stopListening() async {
    await _speechToText!.stop();
    print('stop listen');
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    isFinalListen = result.finalResult;
    _lastWords = result.recognizedWords;
    print(_lastWords);
    print(isFinalListen);
  }

// top here

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
                    color: themeData.getAccentColor2(
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
                    controller: _suggestionController,
                    suggestions: suggestionList,
                    //clearOnSubmit: true,
                    cursorColor: themeData.getSelectedButtonColor(
                        viewModeController.indexThemeData.value),
                    style: TextStyle(
                        color: themeData.getSelectedButtonColor(
                            viewModeController.indexThemeData.value),
                        fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                              color: themeData.getSelectedButtonColor(
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
                      _suggestionController.text = item.toString();
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
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: FloatingActionButton(
                onPressed: _speechToText!.isNotListening
                    ? _startListening
                    : _stopListening,
                tooltip: 'Listen',
                backgroundColor: themeData
                    .getPrimaryColor(viewModeController.indexThemeData.value),
                child: Icon(
                  Icons.mic_outlined,
                  color: themeData
                      .getAccentColor(viewModeController.indexThemeData.value),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _speechToText!.stop();
    _speechToText!.cancel();
    _speechToText = null;
    print('dispose');
    super.dispose();
  }
}
