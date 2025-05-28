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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
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
    return Intl.message('1.0', name: 'PantallaMain', desc: '', args: []);
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

  /// `Graphs`
  String get graphs {
    return Intl.message('Graphs', name: 'graphs', desc: '', args: []);
  }

  /// `Milestones`
  String get milestones {
    return Intl.message('Milestones', name: 'milestones', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Plant care tips`
  String get screenTitlePlantTips {
    return Intl.message(
      'Plant care tips',
      name: 'screenTitlePlantTips',
      desc: '',
      args: [],
    );
  }

  /// `Tip: {text}`
  String plantTipDescription(Object text) {
    return Intl.message(
      'Tip: $text',
      name: 'plantTipDescription',
      desc: '',
      args: [text],
    );
  }

  /// `Zone: {zone}`
  String zoneLabel(Object zone) {
    return Intl.message(
      'Zone: $zone',
      name: 'zoneLabel',
      desc: '',
      args: [zone],
    );
  }

  /// `Measurement Type: {type}`
  String measurementTypeLabel(Object type) {
    return Intl.message(
      'Measurement Type: $type',
      name: 'measurementTypeLabel',
      desc: '',
      args: [type],
    );
  }

  /// `Range: {min} - {max}`
  String rangeLabel(Object min, Object max) {
    return Intl.message(
      'Range: $min - $max',
      name: 'rangeLabel',
      desc: '',
      args: [min, max],
    );
  }

  /// `Min Hours: {min}, Max Hours: {max}`
  String hoursLabel(Object min, Object max) {
    return Intl.message(
      'Min Hours: $min, Max Hours: $max',
      name: 'hoursLabel',
      desc: '',
      args: [min, max],
    );
  }

  /// `No connection`
  String get noConnectionTitle {
    return Intl.message(
      'No connection',
      name: 'noConnectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to the server.\nPlease check your network and ensure the smart pot is powered on and connected to Wi-Fi.`
  String get noConnectionMessage {
    return Intl.message(
      'Could not connect to the server.\nPlease check your network and ensure the smart pot is powered on and connected to Wi-Fi.',
      name: 'noConnectionMessage',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get noConnectionAccept {
    return Intl.message('OK', name: 'noConnectionAccept', desc: '', args: []);
  }

  /// `Select days`
  String get selectDays {
    return Intl.message('Select days', name: 'selectDays', desc: '', args: []);
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Days back:`
  String get daysBack {
    return Intl.message('Days back:', name: 'daysBack', desc: '', args: []);
  }

  /// `Update Graph`
  String get updateGraph {
    return Intl.message(
      'Update Graph',
      name: 'updateGraph',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noData {
    return Intl.message(
      'No data available',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Date and Time`
  String get dateTimeAxis {
    return Intl.message(
      'Date and Time',
      name: 'dateTimeAxis',
      desc: '',
      args: [],
    );
  }

  /// `Percentage (%)`
  String get percentageAxis {
    return Intl.message(
      'Percentage (%)',
      name: 'percentageAxis',
      desc: '',
      args: [],
    );
  }

  /// `{count} days`
  String daysCount(Object count) {
    return Intl.message(
      '$count days',
      name: 'daysCount',
      desc: '',
      args: [count],
    );
  }

  /// `Lux`
  String get lux {
    return Intl.message('Lux', name: 'lux', desc: '', args: []);
  }

  /// `Temperature (ºC)`
  String get degrees {
    return Intl.message(
      'Temperature (ºC)',
      name: 'degrees',
      desc: '',
      args: [],
    );
  }

  /// `HUMIDITY`
  String get humiditySensor {
    return Intl.message('HUMIDITY', name: 'humiditySensor', desc: '', args: []);
  }

  /// `AMBIENT HUMIDITY`
  String get ambienthumiditySensor {
    return Intl.message(
      'AMBIENT HUMIDITY',
      name: 'ambienthumiditySensor',
      desc: '',
      args: [],
    );
  }

  /// `LUMINOSITY`
  String get luminositySensor {
    return Intl.message(
      'LUMINOSITY',
      name: 'luminositySensor',
      desc: '',
      args: [],
    );
  }

  /// `TEMPERATURE`
  String get temperatureSensor {
    return Intl.message(
      'TEMPERATURE',
      name: 'temperatureSensor',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingMessage {
    return Intl.message(
      'Loading...',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Water the plant, it needs more moisture.`
  String get soilMoistureLow {
    return Intl.message(
      'Water the plant, it needs more moisture.',
      name: 'soilMoistureLow',
      desc: '',
      args: [],
    );
  }

  /// `Don't water it more, the soil is too wet.`
  String get soilMoistureHigh {
    return Intl.message(
      'Don\'t water it more, the soil is too wet.',
      name: 'soilMoistureHigh',
      desc: '',
      args: [],
    );
  }

  /// `Soil moisture is in the optimal range.`
  String get soilMoistureOptimal {
    return Intl.message(
      'Soil moisture is in the optimal range.',
      name: 'soilMoistureOptimal',
      desc: '',
      args: [],
    );
  }

  /// `Increase air humidity, place a humidifier nearby.`
  String get airHumidityLow {
    return Intl.message(
      'Increase air humidity, place a humidifier nearby.',
      name: 'airHumidityLow',
      desc: '',
      args: [],
    );
  }

  /// `Reduce humidity, ventilate the area.`
  String get airHumidityHigh {
    return Intl.message(
      'Reduce humidity, ventilate the area.',
      name: 'airHumidityHigh',
      desc: '',
      args: [],
    );
  }

  /// `Air humidity is in the optimal range.`
  String get airHumidityOptimal {
    return Intl.message(
      'Air humidity is in the optimal range.',
      name: 'airHumidityOptimal',
      desc: '',
      args: [],
    );
  }

  /// `The plant needs more light, move it to a brighter spot.`
  String get lightLow {
    return Intl.message(
      'The plant needs more light, move it to a brighter spot.',
      name: 'lightLow',
      desc: '',
      args: [],
    );
  }

  /// `The plant is getting too much light, place it in the shade.`
  String get lightHigh {
    return Intl.message(
      'The plant is getting too much light, place it in the shade.',
      name: 'lightHigh',
      desc: '',
      args: [],
    );
  }

  /// `Light levels are in the optimal range.`
  String get lightOptimal {
    return Intl.message(
      'Light levels are in the optimal range.',
      name: 'lightOptimal',
      desc: '',
      args: [],
    );
  }

  /// `It's too cold, move the plant to a warmer place.`
  String get temperatureLow {
    return Intl.message(
      'It\'s too cold, move the plant to a warmer place.',
      name: 'temperatureLow',
      desc: '',
      args: [],
    );
  }

  /// `It's too hot, keep the plant away from direct sunlight.`
  String get temperatureHigh {
    return Intl.message(
      'It\'s too hot, keep the plant away from direct sunlight.',
      name: 'temperatureHigh',
      desc: '',
      args: [],
    );
  }

  /// `Temperature is in the optimal range.`
  String get temperatureOptimal {
    return Intl.message(
      'Temperature is in the optimal range.',
      name: 'temperatureOptimal',
      desc: '',
      args: [],
    );
  }

  /// `Milestones`
  String get milestonesTitle {
    return Intl.message(
      'Milestones',
      name: 'milestonesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Milestone Progress`
  String get milestonesProgress {
    return Intl.message(
      'Milestone Progress',
      name: 'milestonesProgress',
      desc: '',
      args: [],
    );
  }

  /// `Daily Milestones`
  String get dailyMilestones {
    return Intl.message(
      'Daily Milestones',
      name: 'dailyMilestones',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Milestones`
  String get monthlyMilestones {
    return Intl.message(
      'Monthly Milestones',
      name: 'monthlyMilestones',
      desc: '',
      args: [],
    );
  }

  /// `Soon to change`
  String get soonToChange {
    return Intl.message(
      'Soon to change',
      name: 'soonToChange',
      desc: '',
      args: [],
    );
  }

  /// `Soon to add`
  String get soonToAdd {
    return Intl.message('Soon to add', name: 'soonToAdd', desc: '', args: []);
  }

  /// `Recent soil change, all good.`
  String get recentSoilChange {
    return Intl.message(
      'Recent soil change, all good.',
      name: 'recentSoilChange',
      desc: '',
      args: [],
    );
  }

  /// `Less than a month left for the next soil change`
  String get soilChangeInLessThanMonth {
    return Intl.message(
      'Less than a month left for the next soil change',
      name: 'soilChangeInLessThanMonth',
      desc: '',
      args: [],
    );
  }

  /// `Change the plant's soil, the scheduled time has passed.`
  String get soilChangeOverdue {
    return Intl.message(
      'Change the plant\'s soil, the scheduled time has passed.',
      name: 'soilChangeOverdue',
      desc: '',
      args: [],
    );
  }

  /// `Next change`
  String get nextChange {
    return Intl.message('Next change', name: 'nextChange', desc: '', args: []);
  }

  /// `Confirm soil change`
  String get confirmSoilChangeTitle {
    return Intl.message(
      'Confirm soil change',
      name: 'confirmSoilChangeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Have you changed the plant's soil?`
  String get confirmSoilChangeQuestion {
    return Intl.message(
      'Have you changed the plant\'s soil?',
      name: 'confirmSoilChangeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes, I changed it`
  String get yesChanged {
    return Intl.message(
      'Yes, I changed it',
      name: 'yesChanged',
      desc: '',
      args: [],
    );
  }

  /// `Fertilizer recently added.`
  String get fertilizerRecentlyAdded {
    return Intl.message(
      'Fertilizer recently added.',
      name: 'fertilizerRecentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Less than a month to add fertilizer again`
  String get fertilizerInLessThanMonth {
    return Intl.message(
      'Less than a month to add fertilizer again',
      name: 'fertilizerInLessThanMonth',
      desc: '',
      args: [],
    );
  }

  /// `Add fertilizer, the scheduled time has passed`
  String get fertilizerOverdue {
    return Intl.message(
      'Add fertilizer, the scheduled time has passed',
      name: 'fertilizerOverdue',
      desc: '',
      args: [],
    );
  }

  /// `Next application`
  String get nextApplication {
    return Intl.message(
      'Next application',
      name: 'nextApplication',
      desc: '',
      args: [],
    );
  }

  /// `Confirm fertilizer`
  String get confirmFertilizerTitle {
    return Intl.message(
      'Confirm fertilizer',
      name: 'confirmFertilizerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Have you added fertilizer to the plant?`
  String get confirmFertilizerQuestion {
    return Intl.message(
      'Have you added fertilizer to the plant?',
      name: 'confirmFertilizerQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes, I did`
  String get yesAdded {
    return Intl.message('Yes, I did', name: 'yesAdded', desc: '', args: []);
  }

  /// `New plant created, fertilizer is needed`
  String get newPlantFertilizerMessage {
    return Intl.message(
      'New plant created, fertilizer is needed',
      name: 'newPlantFertilizerMessage',
      desc: '',
      args: [],
    );
  }

  /// `Newly created plant, mark if soil change is done`
  String get newPlantSoilMessage {
    return Intl.message(
      'Newly created plant, mark if soil change is done',
      name: 'newPlantSoilMessage',
      desc: '',
      args: [],
    );
  }

  /// `You must create a plant before adding a photo`
  String get photoNeedsPlant {
    return Intl.message(
      'You must create a plant before adding a photo',
      name: 'photoNeedsPlant',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get takePhoto {
    return Intl.message('Take photo', name: 'takePhoto', desc: '', args: []);
  }

  /// `Choose from gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Remove photo`
  String get removePhoto {
    return Intl.message(
      'Remove photo',
      name: 'removePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Confirm removal`
  String get confirmPhotoRemoval {
    return Intl.message(
      'Confirm removal',
      name: 'confirmPhotoRemoval',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove the photo?`
  String get areYouSureRemovePhoto {
    return Intl.message(
      'Are you sure you want to remove the photo?',
      name: 'areYouSureRemovePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Yes, remove`
  String get yesRemove {
    return Intl.message('Yes, remove', name: 'yesRemove', desc: '', args: []);
  }

  /// `Tap to add photo`
  String get tapToAddPhoto {
    return Intl.message(
      'Tap to add photo',
      name: 'tapToAddPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `📊 Show charts`
  String get showCharts {
    return Intl.message(
      '📊 Show charts',
      name: 'showCharts',
      desc: '',
      args: [],
    );
  }

  /// `Soil Moisture Chart`
  String get chartSoilMoisture {
    return Intl.message(
      'Soil Moisture Chart',
      name: 'chartSoilMoisture',
      desc: '',
      args: [],
    );
  }

  /// `Ambient Humidity Chart`
  String get chartAmbientHumidity {
    return Intl.message(
      'Ambient Humidity Chart',
      name: 'chartAmbientHumidity',
      desc: '',
      args: [],
    );
  }

  /// `Light Chart`
  String get chartLight {
    return Intl.message('Light Chart', name: 'chartLight', desc: '', args: []);
  }

  /// `Temperature Chart`
  String get chartTemperature {
    return Intl.message(
      'Temperature Chart',
      name: 'chartTemperature',
      desc: '',
      args: [],
    );
  }

  /// `✨ Show Milestones`
  String get showMilestones {
    return Intl.message(
      '✨ Show Milestones',
      name: 'showMilestones',
      desc: '',
      args: [],
    );
  }

  /// `Soil Moisture`
  String get milestoneSoilMoisture {
    return Intl.message(
      'Soil Moisture',
      name: 'milestoneSoilMoisture',
      desc: '',
      args: [],
    );
  }

  /// `Ambient Humidity`
  String get milestoneAmbientHumidity {
    return Intl.message(
      'Ambient Humidity',
      name: 'milestoneAmbientHumidity',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get milestoneLight {
    return Intl.message('Light', name: 'milestoneLight', desc: '', args: []);
  }

  /// `Temperature`
  String get milestoneTemperature {
    return Intl.message(
      'Temperature',
      name: 'milestoneTemperature',
      desc: '',
      args: [],
    );
  }

  /// `Soil Change`
  String get milestoneSoilChange {
    return Intl.message(
      'Soil Change',
      name: 'milestoneSoilChange',
      desc: '',
      args: [],
    );
  }

  /// `Fertilizer`
  String get milestoneFertilizer {
    return Intl.message(
      'Fertilizer',
      name: 'milestoneFertilizer',
      desc: '',
      args: [],
    );
  }

  /// `⏳ Soil change frequency (days)`
  String get soilChangeFrequency {
    return Intl.message(
      '⏳ Soil change frequency (days)',
      name: 'soilChangeFrequency',
      desc: '',
      args: [],
    );
  }

  /// `⏳ Fertilizer frequency (days)`
  String get fertilizerFrequency {
    return Intl.message(
      '⏳ Fertilizer frequency (days)',
      name: 'fertilizerFrequency',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get change_language {
    return Intl.message(
      'Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message('Spanish', name: 'spanish', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Active Sensors`
  String get activeSensors {
    return Intl.message(
      'Active Sensors',
      name: 'activeSensors',
      desc: '',
      args: [],
    );
  }

  /// `No data retrieved`
  String get errorFetchingData {
    return Intl.message(
      'No data retrieved',
      name: 'errorFetchingData',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get withOutData {
    return Intl.message('No data', name: 'withOutData', desc: '', args: []);
  }

  /// `Unknown name`
  String get unknownName {
    return Intl.message(
      'Unknown name',
      name: 'unknownName',
      desc: '',
      args: [],
    );
  }

  /// `Unknown model`
  String get unknownModel {
    return Intl.message(
      'Unknown model',
      name: 'unknownModel',
      desc: '',
      args: [],
    );
  }

  /// `Unknown type`
  String get unknownType {
    return Intl.message(
      'Unknown type',
      name: 'unknownType',
      desc: '',
      args: [],
    );
  }

  /// `Unspecified zone`
  String get unknownZone {
    return Intl.message(
      'Unspecified zone',
      name: 'unknownZone',
      desc: '',
      args: [],
    );
  }

  /// `No reading`
  String get noReading {
    return Intl.message('No reading', name: 'noReading', desc: '', args: []);
  }

  /// `No unit`
  String get noUnit {
    return Intl.message('No unit', name: 'noUnit', desc: '', args: []);
  }

  /// `Model`
  String get model {
    return Intl.message('Model', name: 'model', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Zone`
  String get zone {
    return Intl.message('Zone', name: 'zone', desc: '', args: []);
  }

  /// `Last reading`
  String get lastReading {
    return Intl.message(
      'Last reading',
      name: 'lastReading',
      desc: '',
      args: [],
    );
  }

  /// `Please complete all fields`
  String get completeFieldsMessage {
    return Intl.message(
      'Please complete all fields',
      name: 'completeFieldsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Plant type created successfully`
  String get tipoPlantaCreatedMessage {
    return Intl.message(
      'Plant type created successfully',
      name: 'tipoPlantaCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Step 1: Select or Create Plant Type`
  String get step1Title {
    return Intl.message(
      'Step 1: Select or Create Plant Type',
      name: 'step1Title',
      desc: '',
      args: [],
    );
  }

  /// `Plant Type`
  String get tipoPlantaLabel {
    return Intl.message(
      'Plant Type',
      name: 'tipoPlantaLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create a new plant type`
  String get createNewTipoPlanta {
    return Intl.message(
      'Create a new plant type',
      name: 'createNewTipoPlanta',
      desc: '',
      args: [],
    );
  }

  /// `Plant Type Name`
  String get nombreTipoPlantaLabel {
    return Intl.message(
      'Plant Type Name',
      name: 'nombreTipoPlantaLabel',
      desc: '',
      args: [],
    );
  }

  /// `Plant Type Description`
  String get descripcionPlantaLabel {
    return Intl.message(
      'Plant Type Description',
      name: 'descripcionPlantaLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save Plant Type`
  String get guardarTipoPlantaButton {
    return Intl.message(
      'Save Plant Type',
      name: 'guardarTipoPlantaButton',
      desc: '',
      args: [],
    );
  }

  /// `Step 2: Create Plant`
  String get step2Title {
    return Intl.message(
      'Step 2: Create Plant',
      name: 'step2Title',
      desc: '',
      args: [],
    );
  }

  /// `Plant Name`
  String get nombrePlantaLabel {
    return Intl.message(
      'Plant Name',
      name: 'nombrePlantaLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create Plant`
  String get crearPlantaButton {
    return Intl.message(
      'Create Plant',
      name: 'crearPlantaButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete Plant`
  String get deletePlantTitle {
    return Intl.message(
      'Delete Plant',
      name: 'deletePlantTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select an active plant to delete:`
  String get selectActivePlantToDelete {
    return Intl.message(
      'Select an active plant to delete:',
      name: 'selectActivePlantToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Active Plants`
  String get activePlantsLabel {
    return Intl.message(
      'Active Plants',
      name: 'activePlantsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete Plant`
  String get deletePlantButton {
    return Intl.message(
      'Delete Plant',
      name: 'deletePlantButton',
      desc: '',
      args: [],
    );
  }

  /// `Please select a plant to delete`
  String get selectPlantToDelete {
    return Intl.message(
      'Please select a plant to delete',
      name: 'selectPlantToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmDeleteTitle {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the plant "{plantName}"?`
  String confirmDeleteMessage(Object plantName) {
    return Intl.message(
      'Are you sure you want to delete the plant "$plantName"?',
      name: 'confirmDeleteMessage',
      desc: '',
      args: [plantName],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Plant deleted successfully`
  String get plantDeletedMessage {
    return Intl.message(
      'Plant deleted successfully',
      name: 'plantDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `No active plant`
  String get noActivePlantTitle {
    return Intl.message(
      'No active plant',
      name: 'noActivePlantTitle',
      desc: '',
      args: [],
    );
  }

  /// `No active plant detected.\n\nPlease create one before continuing.`
  String get noActivePlantMessage {
    return Intl.message(
      'No active plant detected.\n\nPlease create one before continuing.',
      name: 'noActivePlantMessage',
      desc: '',
      args: [],
    );
  }

  /// `Understood`
  String get understood {
    return Intl.message('Understood', name: 'understood', desc: '', args: []);
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

  /// `Indoor Plant`
  String get plantName {
    return Intl.message('Indoor Plant', name: 'plantName', desc: '', args: []);
  }

  /// `View Plant Tips`
  String get viewPlantTips {
    return Intl.message(
      'View Plant Tips',
      name: 'viewPlantTips',
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

  /// `Create Plant`
  String get menu_create_plant {
    return Intl.message(
      'Create Plant',
      name: 'menu_create_plant',
      desc: '',
      args: [],
    );
  }

  /// `Plant Creation`
  String get title {
    return Intl.message('Plant Creation', name: 'title', desc: '', args: []);
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

  /// `Modify Plant`
  String get modifyPlantTitle {
    return Intl.message(
      'Modify Plant',
      name: 'modifyPlantTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select an active plant to modify:`
  String get selectPlantToModify {
    return Intl.message(
      'Select an active plant to modify:',
      name: 'selectPlantToModify',
      desc: '',
      args: [],
    );
  }

  /// `Plant Name`
  String get plantNameLabel {
    return Intl.message(
      'Plant Name',
      name: 'plantNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `New Plant Type`
  String get newPlantTypeLabel {
    return Intl.message(
      'New Plant Type',
      name: 'newPlantTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Modify Plant`
  String get modifyPlantButton {
    return Intl.message(
      'Modify Plant',
      name: 'modifyPlantButton',
      desc: '',
      args: [],
    );
  }

  /// `Please select a plant and a new type`
  String get selectPlantAndTypeMessage {
    return Intl.message(
      'Please select a plant and a new type',
      name: 'selectPlantAndTypeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Plant type successfully modified`
  String get plantTypeModifiedMessage {
    return Intl.message(
      'Plant type successfully modified',
      name: 'plantTypeModifiedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Loading state...`
  String get loadingState {
    return Intl.message(
      'Loading state...',
      name: 'loadingState',
      desc: '',
      args: [],
    );
  }

  /// `Very poor condition`
  String get veryBadState {
    return Intl.message(
      'Very poor condition',
      name: 'veryBadState',
      desc: '',
      args: [],
    );
  }

  /// `Poor condition`
  String get badState {
    return Intl.message('Poor condition', name: 'badState', desc: '', args: []);
  }

  /// `Fair condition`
  String get regularState {
    return Intl.message(
      'Fair condition',
      name: 'regularState',
      desc: '',
      args: [],
    );
  }

  /// `Good condition`
  String get goodState {
    return Intl.message(
      'Good condition',
      name: 'goodState',
      desc: '',
      args: [],
    );
  }

  /// `Very good condition`
  String get veryGoodState {
    return Intl.message(
      'Very good condition',
      name: 'veryGoodState',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknownState {
    return Intl.message('Unknown', name: 'unknownState', desc: '', args: []);
  }

  /// `Health status: {percent}%`
  String healthStatus(Object percent) {
    return Intl.message(
      'Health status: $percent%',
      name: 'healthStatus',
      desc: '',
      args: [percent],
    );
  }

  /// `Plant Name`
  String get nameLabel {
    return Intl.message('Plant Name', name: 'nameLabel', desc: '', args: []);
  }

  /// `Plant Type`
  String get typeLabel {
    return Intl.message('Plant Type', name: 'typeLabel', desc: '', args: []);
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
    Object water,
  ) {
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
        water,
      ],
    );
  }

  /// `Plant created successfully`
  String get plantaCreatedMessage {
    return Intl.message(
      'Plant created successfully',
      name: 'plantaCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `TOMATO`
  String get welcomeMessage {
    return Intl.message('TOMATO', name: 'welcomeMessage', desc: '', args: []);
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

  /// `Plant Tips`
  String get appTitleplants {
    return Intl.message(
      'Plant Tips',
      name: 'appTitleplants',
      desc: '',
      args: [],
    );
  }

  /// `Plant Tips`
  String get screenTitleplants {
    return Intl.message(
      'Plant Tips',
      name: 'screenTitleplants',
      desc: '',
      args: [],
    );
  }

  /// `Could not fetch plant tips`
  String get errorMessage {
    return Intl.message(
      'Could not fetch plant tips',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Unit: {unit}`
  String unitLabel(Object unit) {
    return Intl.message(
      'Unit: $unit',
      name: 'unitLabel',
      desc: '',
      args: [unit],
    );
  }

  /// `Active Sensors`
  String get appTitlesensors {
    return Intl.message(
      'Active Sensors',
      name: 'appTitlesensors',
      desc: '',
      args: [],
    );
  }

  /// `Active Sensors`
  String get screenTitlesensors {
    return Intl.message(
      'Active Sensors',
      name: 'screenTitlesensors',
      desc: '',
      args: [],
    );
  }

  /// `Could not fetch sensors`
  String get errorMessagesensors {
    return Intl.message(
      'Could not fetch sensors',
      name: 'errorMessagesensors',
      desc: '',
      args: [],
    );
  }

  /// `Model: {model}`
  String modelLabel(Object model) {
    return Intl.message(
      'Model: $model',
      name: 'modelLabel',
      desc: '',
      args: [model],
    );
  }

  /// `Type: {type}`
  String typeLabelsensors(Object type) {
    return Intl.message(
      'Type: $type',
      name: 'typeLabelsensors',
      desc: '',
      args: [type],
    );
  }

  /// `Reading: {reading} {unit}`
  String readingLabel(Object reading, Object unit) {
    return Intl.message(
      'Reading: $reading $unit',
      name: 'readingLabel',
      desc: '',
      args: [reading, unit],
    );
  }

  /// `Please enter all fields.`
  String get pleaseEnterAllFields {
    return Intl.message(
      'Please enter all fields.',
      name: 'pleaseEnterAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Plant created successfully!`
  String get plantCreatedSuccess {
    return Intl.message(
      'Plant created successfully!',
      name: 'plantCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error creating plant`
  String get errorCreatingPlant {
    return Intl.message(
      'Error creating plant',
      name: 'errorCreatingPlant',
      desc: '',
      args: [],
    );
  }

  /// `Error connecting to the server.`
  String get errorConnectingToServer {
    return Intl.message(
      'Error connecting to the server.',
      name: 'errorConnectingToServer',
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
