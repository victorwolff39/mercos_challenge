import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatPrice(double value) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatCurrency.format(value).toString();
  }
}