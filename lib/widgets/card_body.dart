// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';
import 'package:untitled/pages/home_page/home_page.dart';

class CardBody extends StatelessWidget {
  Item item;

  CardBody({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        detailDialog(context, item, item.getImgID());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            dismissible: null,
            motion: const DrawerMotion(),
            extentRatio: 0.3,
            children: [
              SlidableAction(
                autoClose: true,
                flex: 1,
                onPressed: (value) {
                  refreshController.removeCity(item.getId());
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(18),
                icon: Icons.delete,
                label: 'Remove',
              ),
            ],
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "./assets/images/item_thumbnails/img${item.getImgID()}.jpg",
                  ),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.95), BlendMode.dstATop),
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 88,
                    width: 360,
                    child: Stack(
                      children: [
                        Positioned(
                            top: -2,
                            left: 1,
                            child: Opacity(
                              opacity: 0.98,
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                width: 76,
                                height: 76,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/weather_icons/icons${item.getImgID()}.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                          top: 28,
                          child: Text(
                            '${item.getTemperatureC().toStringAsFixed(1)}°C',
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Positioned(
                          top: 38,
                          left: 104,
                          child: SizedBox(
                            height: 26,
                            width: 240,
                            child: Text(
                              item.getStatus(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 12,
                          child: Text(
                            item.getLocation(),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
