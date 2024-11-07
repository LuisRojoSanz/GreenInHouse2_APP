// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `GreenInHouse_2`
  String get MaterialApp {
    return Intl.message(
      'GreenInHouse_2',
      name: 'MaterialApp',
      desc: '',
      args: [],
    );
  }

  /// `1.0`
  String get PantallaMain {
    return Intl.message(
      '1.0',
      name: 'PantallaMain',
      desc: '',
      args: [],
    );
  }

  /// `GreenInHouse_2`
  String get MainTitle {
    return Intl.message(
      'GreenInHouse_2',
      name: 'MainTitle',
      desc: '',
      args: [],
    );
  }

  /// `1.0`
  String get PantallaCreacionPlantas {
    return Intl.message(
      '1.0',
      name: 'PantallaCreacionPlantas',
      desc: '',
      args: [],
    );
  }

  /// `Plant Creation`
  String get title {
    return Intl.message(
      'Plant Creation',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Plant Name`
  String get nameLabel {
    return Intl.message(
      'Plant Name',
      name: 'nameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Plant Type`
  String get typeLabel {
    return Intl.message(
      'Plant Type',
      name: 'typeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Planting Date`
  String get plantDateLabel {
    return Intl.message(
      'Planting Date',
      name: 'plantDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Max Temperature (°C)`
  String get maxTempLabel {
    return Intl.message(
      'Max Temperature (°C)',
      name: 'maxTempLabel',
      desc: '',
      args: [],
    );
  }

  /// `Min Temperature (°C)`
  String get minTempLabel {
    return Intl.message(
      'Min Temperature (°C)',
      name: 'minTempLabel',
      desc: '',
      args: [],
    );
  }

  /// `Max Humidity (%)`
  String get maxHumidityLabel {
    return Intl.message(
      'Max Humidity (%)',
      name: 'maxHumidityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Min Humidity (%)`
  String get minHumidityLabel {
    return Intl.message(
      'Min Humidity (%)',
      name: 'minHumidityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Max Light Hours (h)`
  String get maxLightLabel {
    return Intl.message(
      'Max Light Hours (h)',
      name: 'maxLightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Min Light Hours (h)`
  String get minLightLabel {
    return Intl.message(
      'Min Light Hours (h)',
      name: 'minLightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Daily Water (ml)`
  String get waterLabel {
    return Intl.message(
      'Daily Water (ml)',
      name: 'waterLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add Plant`
  String get addPlantButton {
    return Intl.message(
      'Add Plant',
      name: 'addPlantButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the plant name`
  String get pleaseEnterName {
    return Intl.message(
      'Please enter the plant name',
      name: 'pleaseEnterName',
      desc: '',
      args: [],
    );
  }

  /// `Min temperature cannot be greater than max`
  String get tempMinGreaterThanMax {
    return Intl.message(
      'Min temperature cannot be greater than max',
      name: 'tempMinGreaterThanMax',
      desc: '',
      args: [],
    );
  }

  /// `Min humidity cannot be greater than max`
  String get humidityMinGreaterThanMax {
    return Intl.message(
      'Min humidity cannot be greater than max',
      name: 'humidityMinGreaterThanMax',
      desc: '',
      args: [],
    );
  }

  /// `Min light hours cannot be greater than max`
  String get lightMinGreaterThanMax {
    return Intl.message(
      'Min light hours cannot be greater than max',
      name: 'lightMinGreaterThanMax',
      desc: '',
      args: [],
    );
  }

  /// `Type: {type}\nPlanting Date: {date}\nMax Temp: {maxTemp}°C\nMin Temp: {minTemp}°C\nMax Humidity: {maxHumidity}%\nMin Humidity: {minHumidity}%\nLight: {minLight}-{maxLight}h\nWater: {water}ml/day`
  String plant_info(
      Object type,
      Object date,
      Object maxTemp,
      Object minTemp,
      Object maxHumidity,
      Object minHumidity,
      Object minLight,
      Object maxLight,
      Object water) {
    return Intl.message(
      'Type: $type\nPlanting Date: $date\nMax Temp: $maxTemp°C\nMin Temp: $minTemp°C\nMax Humidity: $maxHumidity%\nMin Humidity: $minHumidity%\nLight: $minLight-${maxLight}h\nWater: ${water}ml/day',
      name: 'plant_info',
      desc: '',
      args: [
        type,
        date,
        maxTemp,
        minTemp,
        maxHumidity,
        minHumidity,
        minLight,
        maxLight,
        water
      ],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `1.0`
  String get PantallaInicio {
    return Intl.message(
      '1.0',
      name: 'PantallaInicio',
      desc: '',
      args: [],
    );
  }

  /// `Days with life`
  String get daysWithLife {
    return Intl.message(
      'Days with life',
      name: 'daysWithLife',
      desc: '',
      args: [],
    );
  }

  /// `TOMATO`
  String get welcomeMessage {
    return Intl.message(
      'TOMATO',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Indoor Plant`
  String get plantName {
    return Intl.message(
      'Indoor Plant',
      name: 'plantName',
      desc: '',
      args: [],
    );
  }

  /// `In good condition`
  String get plantStatus {
    return Intl.message(
      'In good condition',
      name: 'plantStatus',
      desc: '',
      args: [],
    );
  }

  /// `Health Status: 75%`
  String get plantHealth {
    return Intl.message(
      'Health Status: 75%',
      name: 'plantHealth',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Graphs`
  String get graphs {
    return Intl.message(
      'Graphs',
      name: 'graphs',
      desc: '',
      args: [],
    );
  }

  /// `Milestones`
  String get milestones {
    return Intl.message(
      'Milestones',
      name: 'milestones',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Create Plant`
  String get menu_create_plant {
    return Intl.message(
      'Create Plant',
      name: 'menu_create_plant',
      desc: '',
      args: [],
    );
  }

  /// `Modify Plant`
  String get menu_modify_plant {
    return Intl.message(
      'Modify Plant',
      name: 'menu_modify_plant',
      desc: '',
      args: [],
    );
  }

  /// `Plant Tips`
  String get menu_plant_tips {
    return Intl.message(
      'Plant Tips',
      name: 'menu_plant_tips',
      desc: '',
      args: [],
    );
  }

  /// `Delete Plant`
  String get menu_delete_plant {
    return Intl.message(
      'Delete Plant',
      name: 'menu_delete_plant',
      desc: '',
      args: [],
    );
  }

  /// `Sensor Check`
  String get menu_sensor_check {
    return Intl.message(
      'Sensor Check',
      name: 'menu_sensor_check',
      desc: '',
      args: [],
    );
  }

  /// `List of Options`
  String get drawer_header {
    return Intl.message(
      'List of Options',
      name: 'drawer_header',
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
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
