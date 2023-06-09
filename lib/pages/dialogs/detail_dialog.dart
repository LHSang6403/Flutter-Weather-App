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
                          "./assets/images/background_imgs/img${item.getImgID()}.jpg"),
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
                  height: 190,
                  width: MediaQuery.of(context).size.width - 90,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 82,
                          width: 260,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 4,
                                top: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/weather_icons/icons${item.getImgID()}.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                child: Flexible(
                                  child: Expanded(
                                    child: Text(
                                      item.getStatus(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        color: themeData.getPrimaryColor(
                                            viewModeController
                                                .indexThemeData.value),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 50,
                                left: 20,
                                child: SizedBox(
                                  width: 160,
                                  child: Text(
                                    '${item.getTemperatureC()}°C',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                      color: themeData.getPrimaryColor(
                                          viewModeController
                                              .indexThemeData.value),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 56,
                                left: 120,
                                child: SizedBox(
                                  width: 190,
                                  child: Text(
                                    '${item.getTemperatureF()}°F',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: themeData.getPrimaryColor(
                                          viewModeController
                                              .indexThemeData.value),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: themeData.getPrimaryColor(
                              viewModeController.indexThemeData.value),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.getLocation() != item.getCountry()
                                    ? '${item.getLocation()}, ${item.getCountry()}'
                                    : item.getCountry(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: themeData.getPrimaryColor(
                                      viewModeController.indexThemeData.value),
                                ),
                              ),
                              Text(
                                'Local time: ${item.getLocalTime()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: themeData.getPrimaryColor(
                                      viewModeController.indexThemeData.value),
                                ),
                              ),
                              Text(
                                'Last update: ${item.getLastUpdate()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: themeData.getPrimaryColor(
                                      viewModeController.indexThemeData.value),
                                ),
                              ),
                            ],
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
