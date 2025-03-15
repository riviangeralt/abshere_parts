extension StringExtension on String {
  String toInterpolate(dynamic value) {
    return replaceAll('%@', value);
  }
}
