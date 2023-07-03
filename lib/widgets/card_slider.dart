// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';

class CardSlider extends StatelessWidget {
  CardSlider({
    Key? key,
    required this.item,
  }) : super(key: key);

  Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        detailDialog(context, item, item.getImgID());
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          margin: const EdgeInsets.only(top: 12, bottom: 8, left: 8, right: 8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "./assets/images/background_imgs/img${item.getImgID()}.jpg"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.95), BlendMode.dstATop),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Expanded(
                      child: Text(
                        item.getStatus(),
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.getTemperatureC().toStringAsFixed(1)}°C',
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${item.getTemperatureF().toStringAsFixed(1)}°F',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    item.getLocation(),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                ]),
          )),
    );
  }
}
