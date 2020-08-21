// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Training`
  String get nav_training {
    return Intl.message(
      'Training',
      name: 'nav_training',
      desc: '',
      args: [],
    );
  }

  /// `Workouts`
  String get nav_workouts {
    return Intl.message(
      'Workouts',
      name: 'nav_workouts',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get nav_report {
    return Intl.message(
      'Report',
      name: 'nav_report',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get nav_settings {
    return Intl.message(
      'Settings',
      name: 'nav_settings',
      desc: '',
      args: [],
    );
  }

  /// `total`
  String get training_total {
    return Intl.message(
      'total',
      name: 'training_total',
      desc: '',
      args: [],
    );
  }

  /// `workouts`
  String get training_workouts {
    return Intl.message(
      'workouts',
      name: 'training_workouts',
      desc: '',
      args: [],
    );
  }

  /// `kcal`
  String get training_kcal {
    return Intl.message(
      'kcal',
      name: 'training_kcal',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get training_minutes {
    return Intl.message(
      'minutes',
      name: 'training_minutes',
      desc: '',
      args: [],
    );
  }

  /// `week goal`
  String get training_wg {
    return Intl.message(
      'week goal',
      name: 'training_wg',
      desc: '',
      args: [],
    );
  }

  /// `7X4 challenge`
  String get training_7x4 {
    return Intl.message(
      '7X4 challenge',
      name: 'training_7x4',
      desc: '',
      args: [],
    );
  }

  /// `full body`
  String get training_full_body {
    return Intl.message(
      'full body',
      name: 'training_full_body',
      desc: '',
      args: [],
    );
  }

  /// `favorite`
  String get training_favorite {
    return Intl.message(
      'favorite',
      name: 'training_favorite',
      desc: '',
      args: [],
    );
  }

  /// `start your`
  String get training_start {
    return Intl.message(
      'start your',
      name: 'training_start',
      desc: '',
      args: [],
    );
  }

  /// `workout`
  String get training_workout {
    return Intl.message(
      'workout',
      name: 'training_workout',
      desc: '',
      args: [],
    );
  }

  /// `go!`
  String get training_go {
    return Intl.message(
      'go!',
      name: 'training_go',
      desc: '',
      args: [],
    );
  }

  /// `Your favorite workouts will be shown here.`
  String get training_bottom {
    return Intl.message(
      'Your favorite workouts will be shown here.',
      name: 'training_bottom',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get training_btn_start {
    return Intl.message(
      'start',
      name: 'training_btn_start',
      desc: '',
      args: [],
    );
  }

  /// `set your weekly goal`
  String get edit_wg_set {
    return Intl.message(
      'set your weekly goal',
      name: 'edit_wg_set',
      desc: '',
      args: [],
    );
  }

  /// `We recommend training at least 3 days weekly for a better result.`
  String get edit_recommend {
    return Intl.message(
      'We recommend training at least 3 days weekly for a better result.',
      name: 'edit_recommend',
      desc: '',
      args: [],
    );
  }

  /// `Weekly training days`
  String get edit_training_day {
    return Intl.message(
      'Weekly training days',
      name: 'edit_training_day',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get edit_day {
    return Intl.message(
      'day',
      name: 'edit_day',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get edit_days {
    return Intl.message(
      'days',
      name: 'edit_days',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get edit_save {
    return Intl.message(
      'save',
      name: 'edit_save',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get dialog_picker_cancel {
    return Intl.message(
      'cancel',
      name: 'dialog_picker_cancel',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get dialog_picker_ok {
    return Intl.message(
      'ok',
      name: 'dialog_picker_ok',
      desc: '',
      args: [],
    );
  }

  /// `history`
  String get history {
    return Intl.message(
      'history',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get challenge_progress {
    return Intl.message(
      'Progress',
      name: 'challenge_progress',
      desc: '',
      args: [],
    );
  }

  /// `Days left`
  String get challenge_day_left {
    return Intl.message(
      'Days left',
      name: 'challenge_day_left',
      desc: '',
      args: [],
    );
  }

  /// `week`
  String get challenge_week {
    return Intl.message(
      'week',
      name: 'challenge_week',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}