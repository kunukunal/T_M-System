import 'package:intl/intl.dart';

convertDateString(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd MMM').format(dateTime);
  return formattedDate;
}
