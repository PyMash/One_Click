void main(List<String> args) {
  DateTime now = DateTime.now();

  int currentTime = int.parse(now.hour.toString());
  print(currentTime);
}
