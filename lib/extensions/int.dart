// Source: https://stackoverflow.com/a/65314708/7313822
extension RangeExtension on int {
  List<int> upTo(int maxInclusive) =>
      [for (int i = this; i <= maxInclusive; i++) i];
}
