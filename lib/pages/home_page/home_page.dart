// ignore_for_file: unnecessary_overrides

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/items.dart';
import 'package:untitled/data/refresh_indicator_controller.dart';
import 'package:untitled/utils/current_locations/get_current_local_controller.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/bottom_sheets/modal_bottom_delete.dart';
import 'package:untitled/pages/home_page/home_page_controller.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';
import 'package:untitled/widgets/card_body.dart';
import 'package:untitled/widgets/card_slider.dart';
import 'package:untitled/widgets/square_body.dart';

RefreshController refreshController = Get.find();
CurrentLocationController currentLocationController = Get.find();
ViewModeController viewModeController = Get.find();
GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
SliderController sliderController = Get.find();

class HomePage extends StatefulWidget {
  HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void handleOpenRemoveBottomSheet(int id) {
    showRemoveBottomSheet(() {
      refreshController.removeCity(id);
    }, context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() => Scaffold(
        backgroundColor: Colors.white.withOpacity(0.0),
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
                color: themeData.getSelectedButtonColor(
                    viewModeController.indexThemeData.value),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: themeData
              .getPrimaryColor(viewModeController.indexThemeData.value),
        ),
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          color: themeData
              .getSelectedButtonColor(viewModeController.indexThemeData.value),
          backgroundColor: themeData
              .getPrimaryColor(viewModeController.indexThemeData.value),
          strokeWidth: 4.0,
          onRefresh: () async {
            Data? newData = await refreshController.handleRefresh();
            if (newData != null) {
              refreshController.weatherData.value = newData;
            }
            //refreshController.weatherData.value.printOut();
            print(refreshController.needRefreshCities);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                items: currentLocationController
                    .currentLocaltionsWeatherData.value.items
                    .map((item) => CardSlider(
                          item: item,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 160,
                  onPageChanged: (index, reason) {
                    sliderController.slide();
                  },
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                ),
              ),
              Row(
                // Dots indicator:
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: sliderController.getValue() == i
                              ? viewModeController.indexThemeData.value == 0
                                  ? themeData.getPrimaryColor(
                                      viewModeController.indexThemeData.value)
                                  : themeData.getAccentColor(
                                      viewModeController.indexThemeData.value)
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: viewModeController.indexThemeData.value ==
                                      0
                                  ? themeData.getPrimaryColor(
                                      viewModeController.indexThemeData.value)
                                  : themeData
                                      .getAccentColor(viewModeController
                                          .indexThemeData.value)
                                      .withOpacity(0.5))),
                    ),
                ],
              ),
              Expanded(
                  child: viewModeController.viewModesCurrentIndex.value == 0
                      ? listViewOption()
                      : gridViewOption()),
            ],
          ),
        )));
  }

  Widget listViewOption() {
    return Obx(() {
      return SizedBox(
        height: 1000,
        child: ListView.builder(
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
            itemCount: refreshController.weatherData.value.items.length,
            itemBuilder: (BuildContext context, int index) {
              return CardBody(
                item: refreshController.weatherData.value.items[index],
              );
            }),
      );
    });
  }

  Widget gridViewOption() {
    return Obx(() {
      return Container(
          height: 620,
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            padding: const EdgeInsets.all(4),
            itemCount: refreshController.weatherData.value.items.length,
            itemBuilder: (context, index) {
              return SquareBody(
                item: refreshController.weatherData.value.items[index],
                onLongPressFunc: () {
                  handleOpenRemoveBottomSheet(
                      refreshController.weatherData.value.items[index].getId());
                },
              );
            },
          ));
    });
  }

  @override
  bool get wantKeepAlive => true;
}
