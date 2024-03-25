import 'package:intl/intl.dart';

extension CurrencyFormatting on int {
  String toCurrencyFormat() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return formatter.format(this);
  }
}
