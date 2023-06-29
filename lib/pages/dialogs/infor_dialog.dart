import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';

ViewModeController viewModeController = Get.find();

void informationDialog(context) => showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            insetPadding: const EdgeInsets.only(left: 22, right: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 300,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("./assets/images/infor.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                Container(
                  width: 200,
                  height: 300,
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Sang Le',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: themeData.getPrimaryColor(
                              viewModeController.indexThemeData.value),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'I am a CS sophomore, '
                        'passionate about coding and eager to learn '
                        'and grow in this field. I enjoy exploring '
                        'various programming concepts and working on'
                        'projects that challenge and expand my knowledge.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: themeData.getPrimaryColor(
                              viewModeController.indexThemeData.value),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Github.com/LHSang6403\n'
                        'Linkedin.com/6403lhs',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
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
        ));
