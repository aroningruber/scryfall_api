/// Converts [datetime] into a date string with format 'YYYY-MM-DD'.
String? toDateString(DateTime? datetime) {
  if (datetime == null) {
    return null;
  }

  final year = datetime.year.toString().padLeft(4, '0');
  final month = datetime.month.toString().padLeft(2, '0');
  final day = datetime.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}
