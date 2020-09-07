import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:women_fitness_flutter/db/hive/section_history.dart';

class Utils {
  static final String keyIndex = 'index_run';
  static final String sPrefWeight = 'sp_weight';
  static final String sPrefHeight = 'sp_height';
  static final String sPrefIsKgCm = 'sp_is_kg_cm';
  static final String sPrefTimeSet = 'sp_time_set';
  static final String sPrefCountdownTime = 'sp_cd_time';

  static final String sPrefSoundMute = 'sp_sound_mute';
  static final String sPrefSoundVoiceGuide = 'sp_sound_voice';
  static final String sPrefSoundCoachTips = 'sp_sound_coach';

  static final String sPrefIndexVoiceLanguage = 'sp_index_voice';

  static final String sPrefWeekGoal = 'sp_week_goal';

  static final listLanguage = <String>[
    'Vietnamese',
    'English',
    'French',
    'Korean',
    'Spanish',
    'Portuguese',
    'Russian',
  ];

  static final listCodeLanguage = [
    'vi-VN',
    'en-US',
    'fr-FR',
    'ko-KR',
    'es-ES',
    'pt-PT',
    'ru-RU',
  ];

  static String getLanguageDevice(BuildContext context){
    final Locale myLocale= Localizations.localeOf(context);
    return myLocale.languageCode;
  }

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

  static double getTotalCaloriesByDay(String day) {
    double calories = 0;
    var sectionBox = Hive.box('section_history');
    for (int i = 0; i < sectionBox.length; i++) {
      SectionHistory history = sectionBox.getAt(i);
      if (history.day == day) {
        calories += history.calories;
      }
    }
    return calories;
  }

  static double getTotalExercisesByDay(String day) {
    double exercises = 0;
    var sectionBox = Hive.box('section_history');
    for (int i = 0; i < sectionBox.length; i++) {
      SectionHistory history = sectionBox.getAt(i);
      if (history.day == day) {
        exercises++;
      }
    }
    return exercises;
  }

  static String getDateNowFormat() {
    return DateFormat('d/M/yyyy').format(DateTime.now());
  }

  static String getDateNowFormatHour() {
    return DateFormat('hh:mm a d/M/yyyy').format(DateTime.now());
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
