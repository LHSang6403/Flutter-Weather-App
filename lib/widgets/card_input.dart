import 'package:flutter/material.dart';
import 'package:untitled/data/items.dart';

class CardInput extends StatelessWidget {
  CardInput({
    Key? key,
    required this.addCard,
  }) : super(key: key);

  final Function addCard;
  String locationRequest = '';

  void _handleOnCLick(BuildContext context) {
    if (locationRequest.isEmpty) {
      return;
    }
    addCard(locationRequest); // -> run oke
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                locationRequest = text;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Location Code'),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleOnCLick(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                child: const Text(
                  'Add Location',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
