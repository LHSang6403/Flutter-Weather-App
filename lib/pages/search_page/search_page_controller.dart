import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:untitled/pages/dialogs/modal_bottom_add.dart';
import 'package:untitled/pages/search_page/search_page.dart';



class VoiceController extends GetxController {
  RxString lastWords = "".obs;
  bool isFinalListen = false;
  SpeechToText? speechToText = SpeechToText();
  bool speechEnabled = false;
  late BuildContext context;
  late Function addCard;

  void updateLastWords(String input) {
    lastWords.value = input;
  }

  void initSpeech() async {
    speechToText!.initialize(onStatus: (status) {
      if (status == 'done' && isFinalListen) {
        showAddBottomSheet(
          context,
          voiceController.lastWords.value,
          addCard
        );
        isFinalListen = false;
      }
    }).then((value) => speechEnabled = value);
  }

  void startListening() async {
    await speechToText!.listen(
        onResult: (result) => onSpeechResult(result), localeId: 'en_US');
    Timer(const Duration(seconds: 4), stopListening);
  }

  void stopListening() async {
    await speechToText!.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    isFinalListen = result.finalResult;
    lastWords.value = result.recognizedWords;
  }
}
