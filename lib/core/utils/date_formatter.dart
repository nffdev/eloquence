import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();
  
  static String formatToYMD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
  static String getTodayFormatted() {
    return formatToYMD(DateTime.now());
  }
  
  static String formatToReadable(DateTime date) {
    return DateFormat('d MMMM yyyy', 'fr_FR').format(date);
  }
  
  static String getTodayReadable() {
    return formatToReadable(DateTime.now());
  }
}
