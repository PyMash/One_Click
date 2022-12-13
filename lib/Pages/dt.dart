void main(List<String> args) {
  outcome(number) {
    if (number == 0) {
      return "Tutor";
    } else if (number == 1) {
      return "Electrician";
    } else if (number == 2) {
      return "Plumber";
    } else if (number == 3) {
      return "Mechanic";
    } else if (number == 4) {
      return "Assistance";
    } else if (number == 5) {
      return "Driver";
    }
  }

  var data = outcome(1);
  print(data);
}
