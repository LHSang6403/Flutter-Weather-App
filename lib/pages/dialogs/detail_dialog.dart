import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';

ViewModeController viewModeController = Get.find();

Future detailDialog(context, Item item, String id) => showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 160,
              ),
              Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "./assets/images/background_imgs/img$id.jpg"),
                      fit: BoxFit.fill,
                      alignment: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
              Dialog(
                backgroundColor: themeData.getSelectedButtonColor(
                    viewModeController.indexThemeData.value),
                insetPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width - 90,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 14, bottom: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            item.getStatus(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: themeData.getPrimaryColor(
                                  viewModeController.indexThemeData.value),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 4),
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
                              padding: const EdgeInsets.only(top: 4),
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
                          padding: const EdgeInsets.only(top: 4),
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
                          padding: const EdgeInsets.only(top: 4),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(curve: Curves.easeInOut).scale(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 250)));
