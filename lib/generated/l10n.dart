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

  /// `Weight and Height is empty`
  String get report_empty {
    return Intl.message(
      'Weight and Height is empty',
      name: 'report_empty',
      desc: '',
      args: [],
    );
  }

  /// `Calories burned, estimated`
  String get report_chart_1 {
    return Intl.message(
      'Calories burned, estimated',
      name: 'report_chart_1',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get report_chart_1_1 {
    return Intl.message(
      'Calories',
      name: 'report_chart_1_1',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get report_chart_2 {
    return Intl.message(
      'Exercises',
      name: 'report_chart_2',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get report_chart_2_1 {
    return Intl.message(
      'Number',
      name: 'report_chart_2_1',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get report_height {
    return Intl.message(
      'Height',
      name: 'report_height',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get report_edit {
    return Intl.message(
      'edit',
      name: 'report_edit',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get report_current {
    return Intl.message(
      'Current',
      name: 'report_current',
      desc: '',
      args: [],
    );
  }

  /// `Underweight`
  String get report_underweight {
    return Intl.message(
      'Underweight',
      name: 'report_underweight',
      desc: '',
      args: [],
    );
  }

  /// `Normal weight`
  String get report_normal_weight {
    return Intl.message(
      'Normal weight',
      name: 'report_normal_weight',
      desc: '',
      args: [],
    );
  }

  /// `Obesity`
  String get report_obesity {
    return Intl.message(
      'Obesity',
      name: 'report_obesity',
      desc: '',
      args: [],
    );
  }

  /// `Overweight`
  String get report_overweight {
    return Intl.message(
      'Overweight',
      name: 'report_overweight',
      desc: '',
      args: [],
    );
  }

  /// `you rock!`
  String get run_you_rock {
    return Intl.message(
      'you rock!',
      name: 'run_you_rock',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get run_minute {
    return Intl.message(
      'Minutes',
      name: 'run_minute',
      desc: '',
      args: [],
    );
  }

  /// `do it again`
  String get run_again {
    return Intl.message(
      'do it again',
      name: 'run_again',
      desc: '',
      args: [],
    );
  }

  /// `share`
  String get run_share {
    return Intl.message(
      'share',
      name: 'run_share',
      desc: '',
      args: [],
    );
  }

  /// `Three`
  String get run_3 {
    return Intl.message(
      'Three',
      name: 'run_3',
      desc: '',
      args: [],
    );
  }

  /// `Two`
  String get run_2 {
    return Intl.message(
      'Two',
      name: 'run_2',
      desc: '',
      args: [],
    );
  }

  /// `One`
  String get run_1 {
    return Intl.message(
      'One',
      name: 'run_1',
      desc: '',
      args: [],
    );
  }

  /// `Ready to go. Start with`
  String get run_ready {
    return Intl.message(
      'Ready to go. Start with',
      name: 'run_ready',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get run_next {
    return Intl.message(
      'next',
      name: 'run_next',
      desc: '',
      args: [],
    );
  }

  /// `ready to go`
  String get run_ready_go {
    return Intl.message(
      'ready to go',
      name: 'run_ready_go',
      desc: '',
      args: [],
    );
  }

  /// `take a rest`
  String get run_take_a_rest {
    return Intl.message(
      'take a rest',
      name: 'run_take_a_rest',
      desc: '',
      args: [],
    );
  }

  /// `Ten seconds left`
  String get run_10 {
    return Intl.message(
      'Ten seconds left',
      name: 'run_10',
      desc: '',
      args: [],
    );
  }

  /// `Start with`
  String get run_start_with {
    return Intl.message(
      'Start with',
      name: 'run_start_with',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get run_start {
    return Intl.message(
      'Start',
      name: 'run_start',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get run_seconds {
    return Intl.message(
      'seconds',
      name: 'run_seconds',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get setting_profile {
    return Intl.message(
      'My profile',
      name: 'setting_profile',
      desc: '',
      args: [],
    );
  }

  /// `Rest set`
  String get setting_rest_set {
    return Intl.message(
      'Rest set',
      name: 'setting_rest_set',
      desc: '',
      args: [],
    );
  }

  /// `Countdown Time`
  String get setting_countdown_time {
    return Intl.message(
      'Countdown Time',
      name: 'setting_countdown_time',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get setting_sound {
    return Intl.message(
      'Sound',
      name: 'setting_sound',
      desc: '',
      args: [],
    );
  }

  /// `workout`
  String get setting_workout {
    return Intl.message(
      'workout',
      name: 'setting_workout',
      desc: '',
      args: [],
    );
  }

  /// `voice options (tts)`
  String get setting_voice_option {
    return Intl.message(
      'voice options (tts)',
      name: 'setting_voice_option',
      desc: '',
      args: [],
    );
  }

  /// `Test Voice`
  String get setting_test_voice {
    return Intl.message(
      'Test Voice',
      name: 'setting_test_voice',
      desc: '',
      args: [],
    );
  }

  /// `Voice Language`
  String get setting_voice_language {
    return Intl.message(
      'Voice Language',
      name: 'setting_voice_language',
      desc: '',
      args: [],
    );
  }

  /// `general`
  String get setting_general {
    return Intl.message(
      'general',
      name: 'setting_general',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get setting_language {
    return Intl.message(
      'Language',
      name: 'setting_language',
      desc: '',
      args: [],
    );
  }

  /// `Restart Progress`
  String get setting_restart_progress {
    return Intl.message(
      'Restart Progress',
      name: 'setting_restart_progress',
      desc: '',
      args: [],
    );
  }

  /// `Share With Friends`
  String get setting_share {
    return Intl.message(
      'Share With Friends',
      name: 'setting_share',
      desc: '',
      args: [],
    );
  }

  /// `support`
  String get setting_support {
    return Intl.message(
      'support',
      name: 'setting_support',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us 5`
  String get setting_rate {
    return Intl.message(
      'Rate Us 5',
      name: 'setting_rate',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get setting_feedback {
    return Intl.message(
      'Feedback',
      name: 'setting_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Did you hear the test voice ?`
  String get setting_test_speak {
    return Intl.message(
      'Did you hear the test voice ?',
      name: 'setting_test_speak',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get setting_units {
    return Intl.message(
      'Units',
      name: 'setting_units',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get setting_weight {
    return Intl.message(
      'Weight',
      name: 'setting_weight',
      desc: '',
      args: [],
    );
  }

  /// `Year of birth`
  String get setting_birth {
    return Intl.message(
      'Year of birth',
      name: 'setting_birth',
      desc: '',
      args: [],
    );
  }

  /// `edit plan`
  String get training_edit_plan {
    return Intl.message(
      'edit plan',
      name: 'training_edit_plan',
      desc: '',
      args: [],
    );
  }

  /// `reset`
  String get training_reset {
    return Intl.message(
      'reset',
      name: 'training_reset',
      desc: '',
      args: [],
    );
  }

  /// `workouts`
  String get workout_1 {
    return Intl.message(
      'workouts',
      name: 'workout_1',
      desc: '',
      args: [],
    );
  }

  /// `routines`
  String get workout_2 {
    return Intl.message(
      'routines',
      name: 'workout_2',
      desc: '',
      args: [],
    );
  }

  /// `Click`
  String get workout_click_1 {
    return Intl.message(
      'Click',
      name: 'workout_click_1',
      desc: '',
      args: [],
    );
  }

  /// `to add workouts to the Training page.`
  String get workout_click_2 {
    return Intl.message(
      'to add workouts to the Training page.',
      name: 'workout_click_2',
      desc: '',
      args: [],
    );
  }

  /// `abs workout`
  String get workout_abs {
    return Intl.message(
      'abs workout',
      name: 'workout_abs',
      desc: '',
      args: [],
    );
  }

  /// `butt workout`
  String get workout_butt {
    return Intl.message(
      'butt workout',
      name: 'workout_butt',
      desc: '',
      args: [],
    );
  }

  /// `arm workout`
  String get workout_arm {
    return Intl.message(
      'arm workout',
      name: 'workout_arm',
      desc: '',
      args: [],
    );
  }

  /// `thigh workout`
  String get workout_thigh {
    return Intl.message(
      'thigh workout',
      name: 'workout_thigh',
      desc: '',
      args: [],
    );
  }

  /// `Set duration`
  String get dialog_set_duration {
    return Intl.message(
      'Set duration',
      name: 'dialog_set_duration',
      desc: '',
      args: [],
    );
  }

  /// `secs`
  String get dialog_second {
    return Intl.message(
      'secs',
      name: 'dialog_second',
      desc: '',
      args: [],
    );
  }

  /// `set`
  String get dialog_set {
    return Intl.message(
      'set',
      name: 'dialog_set',
      desc: '',
      args: [],
    );
  }

  /// `Sound options`
  String get dialog_sound_op {
    return Intl.message(
      'Sound options',
      name: 'dialog_sound_op',
      desc: '',
      args: [],
    );
  }

  /// `Mute`
  String get dialog_sound_mute {
    return Intl.message(
      'Mute',
      name: 'dialog_sound_mute',
      desc: '',
      args: [],
    );
  }

  /// `Voice guide`
  String get dialog_sound_voice_guide {
    return Intl.message(
      'Voice guide',
      name: 'dialog_sound_voice_guide',
      desc: '',
      args: [],
    );
  }

  /// `Coach tips`
  String get dialog_sound_coach_tips {
    return Intl.message(
      'Coach tips',
      name: 'dialog_sound_coach_tips',
      desc: '',
      args: [],
    );
  }

  /// `Set your weekly training goals`
  String get first_target {
    return Intl.message(
      'Set your weekly training goals',
      name: 'first_target',
      desc: '',
      args: [],
    );
  }

  /// `Set weight and height`
  String get first_weight_height {
    return Intl.message(
      'Set weight and height',
      name: 'first_weight_height',
      desc: '',
      args: [],
    );
  }

  /// `finish`
  String get first_finish {
    return Intl.message(
      'finish',
      name: 'first_finish',
      desc: '',
      args: [],
    );
  }

  /// `Go Premium`
  String get iap_premium {
    return Intl.message(
      'Go Premium',
      name: 'iap_premium',
      desc: '',
      args: [],
    );
  }

  /// `remove ads`
  String get iap_remove {
    return Intl.message(
      'remove ads',
      name: 'iap_remove',
      desc: '',
      args: [],
    );
  }

  /// `unlimited times and features`
  String get iap_unlimited {
    return Intl.message(
      'unlimited times and features',
      name: 'iap_unlimited',
      desc: '',
      args: [],
    );
  }

  /// `Your payment will be charged to your google account, and your subscription will automatically renew for the same price until you cancel in setting in the Android Play Store prior to the end of then current period`
  String get iap_license {
    return Intl.message(
      'Your payment will be charged to your google account, and your subscription will automatically renew for the same price until you cancel in setting in the Android Play Store prior to the end of then current period',
      name: 'iap_license',
      desc: '',
      args: [],
    );
  }

  /// `This feature is a premium feature, you have to pay to use it or view ads!`
  String get iap_dialog_title {
    return Intl.message(
      'This feature is a premium feature, you have to pay to use it or view ads!',
      name: 'iap_dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `View advertisement`
  String get iap_dialog_ads {
    return Intl.message(
      'View advertisement',
      name: 'iap_dialog_ads',
      desc: '',
      args: [],
    );
  }

  /// `Register Premium`
  String get iap_dialog_premium {
    return Intl.message(
      'Register Premium',
      name: 'iap_dialog_premium',
      desc: '',
      args: [],
    );
  }

  /// `Restart progress done!`
  String get snackbar_restart {
    return Intl.message(
      'Restart progress done!',
      name: 'snackbar_restart',
      desc: '',
      args: [],
    );
  }

  /// `gif`
  String get video_gif {
    return Intl.message(
      'gif',
      name: 'video_gif',
      desc: '',
      args: [],
    );
  }

  /// `video`
  String get video {
    return Intl.message(
      'video',
      name: 'video',
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