import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/logics/generate.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';
import '../../main.dart';

ViewModeController viewModeController = Get.find();

Future detailDialog(context, Item item) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(shrinkWrap: true, children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '${item.getLocation()}:',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: themeData.getPrimaryColor(
                        viewModeController.indexThemeData.value),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                  "./assets/images/car${generateRandomFromId(item.getId().toString())}.jpg"),
              const SizedBox(
                height: 14,
              ),
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
                    fontSize: 24,
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
            ]),
          ),
          actions: [
            Center(
              heightFactor: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeData
                      .getPrimaryColor(viewModeController.indexThemeData.value),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: themeData.getAccentColor(
                        viewModeController.indexThemeData.value),
                  ),
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor:
              themeData.getAccentColor(viewModeController.indexThemeData.value),
          elevation: 10.0,
        ));
