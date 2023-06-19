import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled/generate/generate_id.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';
import 'package:untitled/pages/dialogs/information_dialog.dart';

import '/./data/item.dart';

class CardBody extends StatelessWidget {
  CardBody({
    Key? key,
    required this.item,
    required this.deleteCard,
  }) : super(key: key);

  Item item;
  final Function deleteCard;

  @override
  Widget build(BuildContext context) {
    String idImg = generateRandomFromId(item.getId().toString());

    return GestureDetector(
      onTap: () {
        detailDialog(context, item, idImg);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            dismissible: DismissiblePane(onDismissed: () {
              deleteCard(item.getId());
            }),
            motion: const DrawerMotion(),
            extentRatio: 0.3,
            children: [
              SlidableAction(
                autoClose: true,
                flex: 1,
                onPressed: (value) {
                  deleteCard(item.getId());
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
                  image: AssetImage("./assets/images/car$idImg.jpg"),
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
                              '${item.getTemperatureC().toStringAsFixed(1)}°C',
                              style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                item.getStatus(),
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
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
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ]),
                ]),
              )),
        ),
      ),
    );
  }
}
