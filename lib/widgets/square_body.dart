// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';

class SquareBody extends StatelessWidget {
  final VoidCallback onLongPressFunc;
  Item item;
  SquareBody({Key? key, required this.item, required this.onLongPressFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => onLongPressFunc(),
      onTap: () {
        detailDialog(context, item, item.getImgID());
      },
      child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "./assets/images/background_imgs/img${item.getImgID()}.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.95), BlendMode.dstATop),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Stack(
                children: [
                  Positioned(
                      top: 52,
                      left: 0,
                      child: Opacity(
                        opacity: 0.98,
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
                      )),
                  Positioned(
                    top: 92,
                    left: 0,
                    child: Text(
                      '${item.getTemperatureC().toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 0,
                    child: Text(
                      item.getStatus(),
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Positioned(
                    top: 146,
                    left: 4,
                    child: Text(
                      item.getLocation(),
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ))),
    );
  }
}
