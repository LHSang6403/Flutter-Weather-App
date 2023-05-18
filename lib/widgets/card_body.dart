import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class CardBody extends StatelessWidget {
  CardBody({
    Key? key,
    required this.item,
    required this.deleteCard,
  }) : super(key: key);

  var item;
  final Function deleteCard;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(children: [
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.getName(),
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      (item.getTemperature()).toStringAsFixed(1),
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    // pop-up comfirm
                    if (await confirm(context)) {
                      deleteCard(item.getId());
                    }
                    return;
                  },
                  child: const Icon(
                    Icons.remove_circle,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(
                width: 14,
              ),
              Text(
                item.getAddress(),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ]),
          ]),
        ));
  }
}
