import 'package:intl/intl.dart';
import 'constants.dart';

class Utils {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.dateFormat).format(dateTime);
  }

  static String formatBirthdate(DateTime birthdate) {
    return DateFormat.yMMMd().format(birthdate);
  }

  static DateTime parseDate(String dateString) {
    return DateFormat(AppConstants.dateFormat).parse(dateString);
  }
}
