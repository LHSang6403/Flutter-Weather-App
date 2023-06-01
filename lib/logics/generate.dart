import 'dart:math';

int getCurrentDateAsInt() {
  DateTime now = DateTime.now();
  int currentDate =
      int.parse("${now.year}${now.month}${now.day}${now.hour}${now.second}");
  return currentDate;
}

int generateRandomFromId(String id) {
  int hashCode = id.hashCode;
  Random random = Random(hashCode);
  int randomNumber = random.nextInt(11); // Generate random number from 0 to 11
  return randomNumber;
}
