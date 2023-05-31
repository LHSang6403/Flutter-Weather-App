import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/theme/color_converter.dart';
import '/./data/item.dart';

int generateRandomFromId(String id) {
  int hashCode = id.hashCode;
  Random random = Random(hashCode);
  int randomNumber = random.nextInt(7); // Generate random number from 0 to 6
  return randomNumber;
}

class CardBody extends StatelessWidget {
  //HandleColor handleColor;
  final BuildContext parentContext;

  CardBody({
    Key? key,
    required this.item,
    required this.deleteCard,
    required this.parentContext,
  }) : super(key: key);

  Item item;
  final Function deleteCard;
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
            'Remove this weather card',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                deleteCard(item.getId());
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.getId().toString()), // Provide a unique key for each item
      onDismissed: (direction) {
        _dialogBuilder(context);
        //deleteCard(item.getId());
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${item.getLocation()} was removed')));
      },
      background: Container(
        width: MediaQuery.of(context).size.width,
        height: 140,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: HexColor("ff6242"),
        ),
      ),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "./assets/images/img${generateRandomFromId(item.getId().toString())}.jpg"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(18),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (item.getTemperature()).toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              item.getStatus(),
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    item.getLocation(),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ]),
              ]),
            ),
          )),
    );
  }
}
