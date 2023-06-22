import 'package:flutter/material.dart';
import 'package:untitled/data/item.dart';
import 'package:untitled/pages/dialogs/detail_dialog.dart';

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
                  "./assets/images/img${item.getImgID()}.jpg"),
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
