extension StringNumber on String {
  bool isNumeric() {
    try {
      int.parse(this);
      return true;
    } on FormatException {
      return false;
    }
  }
}
