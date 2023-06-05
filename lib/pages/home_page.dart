import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/items.dart';
import 'package:untitled/main.dart';
import 'package:untitled/pages/modal_bottom_delete.dart';
import 'package:untitled/pages/setting_controller.dart';
import 'package:untitled/widgets/card_body.dart';
import 'package:untitled/widgets/square_body.dart';

class HomePage extends StatefulWidget {
  Data weatherData;

  HomePage({Key? key, required this.weatherData});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ViewModeController viewModeController = Get.find();

  void _handleDeleteCard(int id) {
    widget.weatherData.items.removeWhere((item) => id == item.getId());
    setState(() {});
  }

  void handleOpenRemoveBottomSheet(int id) {
    showRemoveBottomSheet(() {
      _handleDeleteCard(id);
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
                  color: themeData
                      .getAccentColor2(viewModeController.indexThemeData.value),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: themeData
                .getPrimaryColor(viewModeController.indexThemeData.value),
          ),
          body: viewModeController.viewModesCurrentIndex.value == 0
              ? listBody()
              : gridBody(),
        ));
  }

  Widget listBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: widget.weatherData.items
            .map((item) => CardBody(
                  item: item,
                  deleteCard: _handleDeleteCard,
                  //parentContext: context,
                ))
            .toList(),
      ),
    );
  }

  Widget gridBody() {
    return Container(padding: const EdgeInsets.all(12), child: buildGridView());
  }

  Widget buildGridView() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        padding: const EdgeInsets.all(4),
        itemCount: widget.weatherData.items.length,
        itemBuilder: (context, index) {
          final item = widget.weatherData.items[index];

          return SquareBody(
            item: item,
            deleteCard: _handleDeleteCard,
            onLongPressFunc: () {
              handleOpenRemoveBottomSheet(item.getId());
            },
          );
        },
      );
}
