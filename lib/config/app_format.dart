import 'package:intl/intl.dart';

class AppFormat {
  static String data(String stringDate) {
    //2023-08-04
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'en_US').format(dateTime); // 4 Aug 2023
  }

  static String dateMonth(String stringDate) {
    //2023-08-04
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM', 'en_US').format(dateTime); // 4 Aug
  }

  static String currency(double number) {
    return NumberFormat.currency(
            decimalDigits: 0, locale: 'en_US', symbol: '\$')
        .format(number);
  }
}
