import 'package:flutter/material.dart';
import '/./data/item.dart';

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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(children: [
            const SizedBox(
              height: 22,
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
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
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
                InkWell(
                  onTap: () async {
                    _dialogBuilder(context);
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
                item.getLocation(),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ]),
          ]),
        ));
  }
}
