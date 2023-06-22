import 'dart:math';

int generateID() {
  DateTime now = DateTime.now();
  int currentDate =
      int.parse("${now.year}${now.month}${now.day}${now.hour}${now.second}");

  currentDate += Random().nextInt(999999);
  currentDate += Random().nextInt(999);

  return currentDate;
}

String generateRandomFromId(String id) {
  int hashCode = id.hashCode;

  hashCode += Random().nextInt(999); // Value is >= 0 and < 10.
  hashCode += Random().nextInt(499);
  hashCode += Random().nextInt(299);
  hashCode += Random().nextInt(99);

  Random random = Random(hashCode);
  int randomNumber = random.nextInt(26); // Generate random number from 0 to 26

  return randomNumber.toString();
}
