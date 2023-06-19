import 'dart:math';

int getCurrentDateAsInt() {
  DateTime now = DateTime.now();
  int currentDate =
      int.parse("${now.year}${now.month}${now.day}${now.hour}${now.second}");
  return currentDate;
}

int getRandomInt(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

String generateRandomFromId(String id) {
  int hashCode = id.hashCode;
  hashCode += getRandomInt(1, 9999);
  Random random = Random(hashCode);
  int randomNumber = random.nextInt(11); // Generate random number from 0 to 11
  
  return randomNumber.toString();
}
