import 'package:intl/intl.dart';

String formatLessonDate(DateTime date) {
  return DateFormat("E, MMM dd, HH:mm").format(date);
}
