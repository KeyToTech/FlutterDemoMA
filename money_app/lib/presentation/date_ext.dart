import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String toStandardFormat() {
    const String pattern = 'dd MMMM yyyy hh:mm aaa';
    return DateFormat(pattern).format(this);
  }

  String toRelativeFormat() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(year, month, day);

    if (aDate == today) {
      return "today";
    } else if (aDate == yesterday) {
      return "yesterday";
    } else {
      const String pattern = 'dd MMMM yyyy';
      return DateFormat(pattern).format(this);
    }
  }
}
