import 'package:flutter/material.dart';
import 'package:untitled/logics/generate.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';

import '/./data/item.dart';

class SquareBody extends StatelessWidget {
  final VoidCallback onLongPressFunc;

  SquareBody(
      {Key? key,
      required this.item,
      required this.deleteCard,
      required this.onLongPressFunc})
      : super(key: key);

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
    return GestureDetector(
      onLongPress: () => onLongPressFunc(),
      onTap: () {
        detailDialog(context, item);
      },
      child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "./assets/images/car${generateRandomFromId(item.getId().toString())}.jpg"),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.95), BlendMode.dstATop),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.getTemperatureC().toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    item.getStatus(),
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    item.getLocation(),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ]),
          )),
    );
  }
}
