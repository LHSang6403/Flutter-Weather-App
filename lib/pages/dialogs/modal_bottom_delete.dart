import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';
import '../../main.dart';

void showRemoveBottomSheet(VoidCallback removeCard, BuildContext context) {
  ViewModeController viewModeController = Get.find();

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
              'Confirm delete this card?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: themeData
                    .getAccentColor(viewModeController.indexThemeData.value),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    removeCard();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeData.getAccentColor(
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
                  child: const Text('Confirm'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeData.getTextColor(viewModeController
                        .indexThemeData.value), // Set the background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set the border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24), // Set the padding
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
