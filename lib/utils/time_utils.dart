class TimeUtils {
  TimeUtils._();

  /// Convert DateString into formatted time
  /// params dateString: String. example: 2024-12-14T08:49:37.671Z
  /// return (if today is 2024-12-14 and is 10:00 AM) then return "2 jam yang lalu"
  /// so the rule is
  /// if on the same day and <1 hour return "{minutes} menit yang lalu" ex: "30 menit yang lalu"
  /// if on the same day and >=1 hour return "{hour} jam yang lalu" ex: "2 jam yang lalu"
  /// if on the same month return "{day} hari yang lalu" ex: "2 hari yang lalu"
  /// if on the same year return "{month} bulan yang lalu" ex: "2 bulan yang lalu"
  /// if different year return "{year} tahun yang lalu" ex: "2 tahun yang lalu"
  static String formatCreatedAt({required String dateString}) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();

      final difference = now.difference(date);

      if (difference.inDays == 0 && now.day == date.day) {
        if (difference.inHours < 1) {
          final minutes = difference.inMinutes;
          return "$minutes menit yang lalu";
        }
        final hours = difference.inHours;
        return "$hours jam yang lalu";
      } else if (now.year == date.year && now.month == date.month) {
        final days = difference.inDays;
        return "$days hari yang lalu";
      } else if (now.year == date.year) {
        final months = now.month - date.month;
        return "$months bulan yang lalu";
      } else {
        final years = now.year - date.year;
        return "$years tahun yang lalu";
      }
    } catch (e) {
      // Handle invalid dateString or parsing errors
      return "Tanggal tidak valid";
    }
  }
}
