import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:untitled/pages/bottom_sheets/modal_bottom_add.dart';
import 'package:untitled/pages/search_page/search_page.dart';

class VoiceController extends GetxController {
  RxString lastWords = "".obs;
  bool isFinalListen = false;
  SpeechToText? speechToText = SpeechToText();
  bool speechEnabled = false;
  late BuildContext context;
  int remainingTime = 4;

  void updateLastWords(String input) {
    lastWords.value = input;
  }

  void initSpeech() async {
    speechToText!.initialize(onStatus: (status) {
      if (status == 'done' && isFinalListen) {
        showAddBottomSheet(
          context,
          voiceController.lastWords.value,
        );
        isFinalListen = false;
      }
    }).then((value) => speechEnabled = value);
  }

  void startListening() async {
    await speechToText!.listen(
        onResult: (result) => onSpeechResult(result), localeId: 'en_US');
    Timer(Duration(seconds: remainingTime), stopListening);
  }

  void stopListening() async {
    await speechToText!.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    isFinalListen = result.finalResult;
    lastWords.value = result.recognizedWords;
  }
}
