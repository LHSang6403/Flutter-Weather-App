import 'package:flutter/material.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';

void InformationDialog({
  required BuildContext context,
  required Item item,
  required Function onPositivePressed,
  required Function onNegativePressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  item.getStatus(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: themeData.getPrimaryColor(
                        viewModeController.indexThemeData.value),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 14, top: 4),
                    child: Text(
                      '${item.getTemperatureC()}°C',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: themeData.getPrimaryColor(
                            viewModeController.indexThemeData.value),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 14, top: 4),
                    child: Text(
                      '${item.getTemperatureF()}°F',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: themeData.getPrimaryColor(
                            viewModeController.indexThemeData.value),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 14, top: 4),
                child: Text(
                  item.getCountry(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: themeData.getPrimaryColor(
                        viewModeController.indexThemeData.value),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 14, top: 4, bottom: 8),
                child: Text(
                  'Local time: ${item.getLocalTime()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: themeData.getPrimaryColor(
                        viewModeController.indexThemeData.value),
                  ),
                ),
              ),
              Divider(
                color: viewModeController.indexThemeData.value == 0
                    ? Colors.black
                    : themeData.getPrimaryColor(
                        viewModeController.indexThemeData.value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => onNegativePressed(),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => onPositivePressed(),
                    child: Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
