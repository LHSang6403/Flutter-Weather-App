import 'dart:async';
import 'package:untitled/data/refresh_indicator_controller.dart';
import 'package:untitled/utils/current_locations/get_current_local_controller.dart';
import 'package:untitled/pages/home_page/home_page_controller.dart';
import 'package:untitled/pages/search_page/search_page_controller.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';
import 'theme/theme_loader.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/search_page/search_page.dart';
import 'package:untitled/pages/setting_page/setting_page.dart';
import 'package:untitled/pages/home_page/home_page.dart';
import 'package:get/get.dart';

ThemeDataModel themeData = ThemeDataModel();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ViewModeController());
  Get.put(VoiceController());
  Get.put(RefreshController());
  Get.put(CurrentLocationController());
  Get.put(SliderController());

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ViewModeController viewModeController = Get.find();
  final VoiceController voiceController = Get.find();
  final RefreshController refreshController = Get.find();
  final CurrentLocationController currentLocationController = Get.find();

  @override
  void initState() {
    super.initState();
    loadJsonAsset();
    loadCurrentLocations();

    voiceController.initSpeech();
    voiceController.context = context;

    pages.add(HomePage());
    pages.add(SearchPage());
    pages.add(SettingsPage());
  }

  Future<void> loadCurrentLocations() async {
    await currentLocationController.updateCurrentLocal();
  }

  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/themes.json');
    final data = jsonDecode(jsonString);
    themeData.parseThemes(data);
  }

  int _currentIndex = 0;
  final List<Widget> pages = [];
  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialApp(
            home: Scaffold(
          backgroundColor: themeData
              .getBackgroundColor(viewModeController.indexThemeData.value),
          body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: themeData
                .getPrimaryColor(viewModeController.indexThemeData.value),
            selectedFontSize: 10,
            selectedIconTheme: IconThemeData(
                color: themeData.getSelectedButtonColor(
                    viewModeController.indexThemeData.value),
                size: 40),
            selectedItemColor: themeData.getSelectedButtonColor(
                viewModeController.indexThemeData.value),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: themeData.getUnselectedButtonColor(
                viewModeController.indexThemeData.value),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        )));
  }
}
