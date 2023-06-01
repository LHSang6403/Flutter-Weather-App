import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/logics/generate.dart';
import 'package:untitled/theme/color_converter.dart';
import '/./data/item.dart';

class CardBody extends StatelessWidget {
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
      key: Key(item.getId().toString()),
      direction:
          DismissDirection.endToStart, // Provide a unique key for each item
      onDismissed: (direction) {
        _dialogBuilder(context);
        //deleteCard(item.getId());
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${item.getLocation()} was removed')));
      },
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 26, top: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: HexColor("ff6242"),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Remove',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "./assets/images/car${generateRandomFromId(item.getId().toString())}.jpg"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.95), BlendMode.dstATop),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${item.getTemperature().toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            item.getStatus(),
                            style: const TextStyle(
                                fontSize: 28, color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  width: 18,
                ),
                Text(
                  item.getLocation(),
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ]),
            ]),
          )),
    );
  }
}
