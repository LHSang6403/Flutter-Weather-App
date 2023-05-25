int getCurrentDateAsInt() {
  DateTime now = DateTime.now();
  int currentDate =
      int.parse("${now.year}${now.month}${now.day}${now.hour}${now.second}");
  return currentDate;
}
