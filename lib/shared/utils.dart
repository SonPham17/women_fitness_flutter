import 'package:intl/intl.dart';

class Utils {
  static final String keyIndex = 'index_run';

  static List<String> getDaysOfWeek(String locale, int controlWeek) {
    final now = DateTime.now();
    final firstDayOfWeek =
        now.subtract(Duration(days: now.weekday - 1 + controlWeek));
    return List.generate(7, (index) => index)
        .map((value) =>
            '${DateFormat(DateFormat.DAY, locale).format(firstDayOfWeek.add(Duration(days: value)))}/${DateFormat(DateFormat.NUM_MONTH, locale).format(firstDayOfWeek.add(Duration(days: value)))}')
        .toList();
  }

  static int getYearFromControl(int controlWeek) {
    final now = DateTime.now();
    final firstDayOfWeek =
        now.subtract(Duration(days: now.weekday - 1 + controlWeek));
    return firstDayOfWeek.year;
  }

  static double calculatorBMI(double f, double f2) {
    return f2 / ((f * f) / 10000.0);
  }

  static double convertCmToFt(double f) => f / 30.48;

  static double convertFtToCm(double f) {
    double f2 = f * 30.48;
    if (f2 < 164.89 || f2 > 165.1) {
      return f2;
    }
    return 165.0;
  }

  static double convertKgToLbs(double f) => f * 2.20462;

  static double convertLbsToKg(double f) => f / 2.20462;

  static String convertSecondToTime(int second) {
    if (second < 60) {
      if (second < 10) {
        return '00:0$second';
      }
      return '00:$second';
    }
    int minute = second ~/ 60;
    int s = second - minute * 60;
    if (s < 10) {
      return '$minute:0$s';
    }
    return '$minute:$s';
  }
}
