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
        width: double.infinity,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.getStatus(),
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
                    //bool isConfirm = await confirm(context);
                    // confirm(context).then((value) {
                    //   if (value) {
                    //     deleteCard(item.getId());
                    //   }
                    // });
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
