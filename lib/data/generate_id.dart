int getCurrentDateAsInt() {
  DateTime now = DateTime.now();
  int currentDate = int.parse("${now.year}${now.month}${now.day}");
  return currentDate;
}
