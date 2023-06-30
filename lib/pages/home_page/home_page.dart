import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/data/items.dart';
import 'package:untitled/data/refresh_indicator_controller.dart';
import 'package:untitled/current_locations/get_current_local_controller.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/dialogs/loading_dialog.dart';
import 'package:untitled/pages/dialogs/modal_bottom_delete.dart';
import 'package:untitled/pages/setting_page/setting_controller.dart';
import 'package:untitled/widgets/card_body.dart';
import 'package:untitled/widgets/card_slider.dart';
import 'package:untitled/widgets/square_body.dart';

RefreshController refreshController = Get.find();
CurrentLocationController currentLocationController = Get.find();
ViewModeController viewModeController = Get.find();
GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

class HomePage extends StatefulWidget {
  HomePage({Key? key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndexSlider = 0;
  @override
  void initState() {
    super.initState();
  }

  void firstLoading() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return const Loading();
      },
    );
  }

  void handleDeleteCard(int id) {
    for (Item item in refreshController.weatherData.value.items) {
      if (id == item.getId()) {
        refreshData.needRefreshCities.remove(item.getLocation());
      }
    }
    refreshController.weatherData.value.items
        .removeWhere((item) => id == item.getId());
    setState(() {});
  }

  void handleOpenRemoveBottomSheet(int id) {
    showRemoveBottomSheet(() {
      handleDeleteCard(id);
    }, context);
  }

  @override
  Widget build(BuildContext context) {
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
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            onRefresh: () async {
              Data? newData = await refreshData.handleRefresh();
              if (newData != null) {
                refreshController.weatherData.value = newData;
              }
            },
            child: SingleChildScrollView(
              child: Column(
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
                        setState(() {
                          currentIndexSlider = index;
                        });
                      },
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++)
                        Container(
                          height: 10,
                          width: 10,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: currentIndexSlider == i
                                  ? viewModeController
                                              .indexThemeData.value == 0
                                      ? themeData.getPrimaryColor(
                                          viewModeController
                                              .indexThemeData.value)
                                      : themeData.getAccentColor(
                                          viewModeController
                                              .indexThemeData.value)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: viewModeController
                                              .indexThemeData.value == 0
                                      ? themeData.getPrimaryColor(
                                          viewModeController
                                              .indexThemeData.value)
                                      : themeData
                                          .getAccentColor(viewModeController
                                              .indexThemeData.value)
                                          .withOpacity(0.5))),
                        ),
                    ],
                  ),
                  viewModeController.viewModesCurrentIndex.value == 0
                      ? listViewOption()
                      : gridViewOption(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget listViewOption() {
    return Obx(() {
      return SizedBox(
        height: 1000,
        child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
            children: [
              Column(
                children: refreshController.weatherData.value.items
                    .map((item) => CardBody(
                          item: item,
                          deleteCard: handleDeleteCard,
                        ))
                    .toList(),
              ),
            ]),
      );
    });
  }

  Widget gridViewOption() {
    return Obx(() {
      return Container(
          height: 620,
          padding: const EdgeInsets.all(12),
          child: gridViewBuilder());
    });
  }

  Widget gridViewBuilder() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        padding: const EdgeInsets.all(4),
        itemCount: refreshController.weatherData.value.items.length,
        itemBuilder: (context, index) {
          final item = refreshController.weatherData.value.items[index];
          return SquareBody(
            item: item,
            deleteCard: handleDeleteCard,
            onLongPressFunc: () {
              handleOpenRemoveBottomSheet(item.getId());
            },
          );
        },
      );
}
