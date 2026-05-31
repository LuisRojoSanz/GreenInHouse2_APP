import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @materialApp.
  ///
  /// In en, this message translates to:
  /// **'GreenInHouse_2'**
  String get materialApp;

  /// No description provided for @pantallaMain.
  ///
  /// In en, this message translates to:
  /// **'1.0'**
  String get pantallaMain;

  /// No description provided for @mainTitle.
  ///
  /// In en, this message translates to:
  /// **'GreenInHouse_2'**
  String get mainTitle;

  /// No description provided for @graphs.
  ///
  /// In en, this message translates to:
  /// **'Graphs'**
  String get graphs;

  /// No description provided for @milestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get milestones;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @screenTitlePlantTips.
  ///
  /// In en, this message translates to:
  /// **'Plant care tips'**
  String get screenTitlePlantTips;

  /// No description provided for @plantTipDescription.
  ///
  /// In en, this message translates to:
  /// **'Tip: {text}'**
  String plantTipDescription(Object text);

  /// No description provided for @zoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Zone: {zone}'**
  String zoneLabel(Object zone);

  /// No description provided for @measurementTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Measurement Type: {type}'**
  String measurementTypeLabel(Object type);

  /// No description provided for @rangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Range: {min} - {max}'**
  String rangeLabel(Object max, Object min);

  /// No description provided for @hoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Min Hours: {min}, Max Hours: {max}'**
  String hoursLabel(Object max, Object min);

  /// No description provided for @noConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get noConnectionTitle;

  /// No description provided for @noConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not connect to the server.\nPlease check your network and ensure the smart pot is powered on and connected to Wi-Fi.'**
  String get noConnectionMessage;

  /// No description provided for @noConnectionAccept.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get noConnectionAccept;

  /// No description provided for @selectDays.
  ///
  /// In en, this message translates to:
  /// **'Select days'**
  String get selectDays;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select dates'**
  String get selectDate;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @daysBack.
  ///
  /// In en, this message translates to:
  /// **'Days back:'**
  String get daysBack;

  /// No description provided for @updateGraph.
  ///
  /// In en, this message translates to:
  /// **'Update Graph'**
  String get updateGraph;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @dateTimeAxis.
  ///
  /// In en, this message translates to:
  /// **'Date and Time'**
  String get dateTimeAxis;

  /// No description provided for @percentageAxis.
  ///
  /// In en, this message translates to:
  /// **'Percentage (%)'**
  String get percentageAxis;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String daysCount(Object count);

  /// No description provided for @lux.
  ///
  /// In en, this message translates to:
  /// **'Lux'**
  String get lux;

  /// No description provided for @degrees.
  ///
  /// In en, this message translates to:
  /// **'Temperature (ºC)'**
  String get degrees;

  /// No description provided for @humiditySensor.
  ///
  /// In en, this message translates to:
  /// **'HUMIDITY'**
  String get humiditySensor;

  /// No description provided for @ambienthumiditySensor.
  ///
  /// In en, this message translates to:
  /// **'AMBIENT HUMIDITY'**
  String get ambienthumiditySensor;

  /// No description provided for @luminositySensor.
  ///
  /// In en, this message translates to:
  /// **'LUMINOSITY'**
  String get luminositySensor;

  /// No description provided for @temperatureSensor.
  ///
  /// In en, this message translates to:
  /// **'TEMPERATURE'**
  String get temperatureSensor;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingMessage;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @soilMoistureLow.
  ///
  /// In en, this message translates to:
  /// **'Water the plant, it needs more moisture.'**
  String get soilMoistureLow;

  /// No description provided for @soilMoistureHigh.
  ///
  /// In en, this message translates to:
  /// **'Don\'t water it more, the soil is too wet.'**
  String get soilMoistureHigh;

  /// No description provided for @soilMoistureOptimal.
  ///
  /// In en, this message translates to:
  /// **'Soil moisture is in the optimal range.'**
  String get soilMoistureOptimal;

  /// No description provided for @airHumidityLow.
  ///
  /// In en, this message translates to:
  /// **'Increase air humidity, place a humidifier nearby.'**
  String get airHumidityLow;

  /// No description provided for @airHumidityHigh.
  ///
  /// In en, this message translates to:
  /// **'Reduce humidity, ventilate the area.'**
  String get airHumidityHigh;

  /// No description provided for @airHumidityOptimal.
  ///
  /// In en, this message translates to:
  /// **'Air humidity is in the optimal range.'**
  String get airHumidityOptimal;

  /// No description provided for @lightLow.
  ///
  /// In en, this message translates to:
  /// **'The plant needs more light, move it to a brighter spot.'**
  String get lightLow;

  /// No description provided for @lightHigh.
  ///
  /// In en, this message translates to:
  /// **'The plant is getting too much light, place it in the shade.'**
  String get lightHigh;

  /// No description provided for @lightOptimal.
  ///
  /// In en, this message translates to:
  /// **'Light levels are in the optimal range.'**
  String get lightOptimal;

  /// No description provided for @temperatureLow.
  ///
  /// In en, this message translates to:
  /// **'It\'s too cold, move the plant to a warmer place.'**
  String get temperatureLow;

  /// No description provided for @temperatureHigh.
  ///
  /// In en, this message translates to:
  /// **'It\'s too hot, keep the plant away from direct sunlight.'**
  String get temperatureHigh;

  /// No description provided for @temperatureOptimal.
  ///
  /// In en, this message translates to:
  /// **'Temperature is in the optimal range.'**
  String get temperatureOptimal;

  /// No description provided for @milestonesTitle.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get milestonesTitle;

  /// No description provided for @milestonesProgress.
  ///
  /// In en, this message translates to:
  /// **'Milestone Progress'**
  String get milestonesProgress;

  /// No description provided for @dailyMilestones.
  ///
  /// In en, this message translates to:
  /// **'Daily Milestones'**
  String get dailyMilestones;

  /// No description provided for @monthlyMilestones.
  ///
  /// In en, this message translates to:
  /// **'Monthly Milestones'**
  String get monthlyMilestones;

  /// No description provided for @soonToChange.
  ///
  /// In en, this message translates to:
  /// **'Soon to change'**
  String get soonToChange;

  /// No description provided for @soonToAdd.
  ///
  /// In en, this message translates to:
  /// **'Soon to add'**
  String get soonToAdd;

  /// No description provided for @recentSoilChange.
  ///
  /// In en, this message translates to:
  /// **'Recent soil change, all good.'**
  String get recentSoilChange;

  /// No description provided for @soilChangeInLessThanMonth.
  ///
  /// In en, this message translates to:
  /// **'Less than a month left for the next soil change'**
  String get soilChangeInLessThanMonth;

  /// No description provided for @soilChangeOverdue.
  ///
  /// In en, this message translates to:
  /// **'Change the plant\'s soil, the scheduled time has passed.'**
  String get soilChangeOverdue;

  /// No description provided for @nextChange.
  ///
  /// In en, this message translates to:
  /// **'Next change'**
  String get nextChange;

  /// No description provided for @confirmSoilChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm soil change'**
  String get confirmSoilChangeTitle;

  /// No description provided for @confirmSoilChangeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you changed the plant\'s soil?'**
  String get confirmSoilChangeQuestion;

  /// No description provided for @yesChanged.
  ///
  /// In en, this message translates to:
  /// **'Yes, I changed it'**
  String get yesChanged;

  /// No description provided for @fertilizerRecentlyAdded.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer recently added.'**
  String get fertilizerRecentlyAdded;

  /// No description provided for @fertilizerInLessThanMonth.
  ///
  /// In en, this message translates to:
  /// **'Less than a month to add fertilizer again'**
  String get fertilizerInLessThanMonth;

  /// No description provided for @fertilizerOverdue.
  ///
  /// In en, this message translates to:
  /// **'Add fertilizer, the scheduled time has passed'**
  String get fertilizerOverdue;

  /// No description provided for @nextApplication.
  ///
  /// In en, this message translates to:
  /// **'Next application'**
  String get nextApplication;

  /// No description provided for @confirmFertilizerTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm fertilizer'**
  String get confirmFertilizerTitle;

  /// No description provided for @confirmFertilizerQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you added fertilizer to the plant?'**
  String get confirmFertilizerQuestion;

  /// No description provided for @yesAdded.
  ///
  /// In en, this message translates to:
  /// **'Yes, I did'**
  String get yesAdded;

  /// No description provided for @newPlantFertilizerMessage.
  ///
  /// In en, this message translates to:
  /// **'New plant created, fertilizer is needed'**
  String get newPlantFertilizerMessage;

  /// No description provided for @newPlantSoilMessage.
  ///
  /// In en, this message translates to:
  /// **'Newly created plant, mark if soil change is done'**
  String get newPlantSoilMessage;

  /// No description provided for @photoNeedsPlant.
  ///
  /// In en, this message translates to:
  /// **'You must create a plant before adding a photo'**
  String get photoNeedsPlant;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @confirmPhotoRemoval.
  ///
  /// In en, this message translates to:
  /// **'Confirm removal'**
  String get confirmPhotoRemoval;

  /// No description provided for @areYouSureRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove the photo?'**
  String get areYouSureRemovePhoto;

  /// No description provided for @yesRemove.
  ///
  /// In en, this message translates to:
  /// **'Yes, remove'**
  String get yesRemove;

  /// No description provided for @tapToAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to add photo'**
  String get tapToAddPhoto;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @showGraphs.
  ///
  /// In en, this message translates to:
  /// **'📊 Show graphs'**
  String get showGraphs;

  /// No description provided for @graphSoilMoisture.
  ///
  /// In en, this message translates to:
  /// **'Soil Moisture Graph'**
  String get graphSoilMoisture;

  /// No description provided for @graphAmbientHumidity.
  ///
  /// In en, this message translates to:
  /// **'Ambient Humidity Graph'**
  String get graphAmbientHumidity;

  /// No description provided for @graphLight.
  ///
  /// In en, this message translates to:
  /// **'Light Graph'**
  String get graphLight;

  /// No description provided for @graphTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature Graph'**
  String get graphTemperature;

  /// No description provided for @showMilestones.
  ///
  /// In en, this message translates to:
  /// **'✨ Show Milestones'**
  String get showMilestones;

  /// No description provided for @milestoneSoilMoisture.
  ///
  /// In en, this message translates to:
  /// **'Soil Moisture'**
  String get milestoneSoilMoisture;

  /// No description provided for @milestoneAmbientHumidity.
  ///
  /// In en, this message translates to:
  /// **'Ambient Humidity'**
  String get milestoneAmbientHumidity;

  /// No description provided for @milestoneLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get milestoneLight;

  /// No description provided for @milestoneTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get milestoneTemperature;

  /// No description provided for @milestoneSoilChange.
  ///
  /// In en, this message translates to:
  /// **'Soil Change'**
  String get milestoneSoilChange;

  /// No description provided for @milestoneFertilizer.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer'**
  String get milestoneFertilizer;

  /// No description provided for @soilChangeFrequency.
  ///
  /// In en, this message translates to:
  /// **'⏳ Soil change frequency (days)'**
  String get soilChangeFrequency;

  /// No description provided for @fertilizerFrequency.
  ///
  /// In en, this message translates to:
  /// **'⏳ Fertilizer frequency (days)'**
  String get fertilizerFrequency;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get change_language;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @activeSensors.
  ///
  /// In en, this message translates to:
  /// **'Active Sensors'**
  String get activeSensors;

  /// No description provided for @errorFetchingData.
  ///
  /// In en, this message translates to:
  /// **'No data retrieved'**
  String get errorFetchingData;

  /// No description provided for @withOutData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get withOutData;

  /// No description provided for @unknownName.
  ///
  /// In en, this message translates to:
  /// **'Unknown name'**
  String get unknownName;

  /// No description provided for @unknownModel.
  ///
  /// In en, this message translates to:
  /// **'Unknown model'**
  String get unknownModel;

  /// No description provided for @unknownType.
  ///
  /// In en, this message translates to:
  /// **'Unknown type'**
  String get unknownType;

  /// No description provided for @unknownZone.
  ///
  /// In en, this message translates to:
  /// **'Unspecified zone'**
  String get unknownZone;

  /// No description provided for @noReading.
  ///
  /// In en, this message translates to:
  /// **'No reading'**
  String get noReading;

  /// No description provided for @noUnit.
  ///
  /// In en, this message translates to:
  /// **'No unit'**
  String get noUnit;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @zone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zone;

  /// No description provided for @lastReading.
  ///
  /// In en, this message translates to:
  /// **'Last reading'**
  String get lastReading;

  /// No description provided for @completeFieldsMessage.
  ///
  /// In en, this message translates to:
  /// **'Please complete all fields'**
  String get completeFieldsMessage;

  /// No description provided for @tipoPlantaCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Plant type created successfully'**
  String get tipoPlantaCreatedMessage;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Select or Create Plant Type'**
  String get step1Title;

  /// No description provided for @tipoPlantaLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Type'**
  String get tipoPlantaLabel;

  /// No description provided for @createNewTipoPlanta.
  ///
  /// In en, this message translates to:
  /// **'Create a new plant type'**
  String get createNewTipoPlanta;

  /// No description provided for @nombreTipoPlantaLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Type Name'**
  String get nombreTipoPlantaLabel;

  /// No description provided for @descripcionPlantaLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Type Description'**
  String get descripcionPlantaLabel;

  /// No description provided for @guardarTipoPlantaButton.
  ///
  /// In en, this message translates to:
  /// **'Save Plant Type'**
  String get guardarTipoPlantaButton;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Create Plant'**
  String get step2Title;

  /// No description provided for @nombrePlantaLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Name'**
  String get nombrePlantaLabel;

  /// No description provided for @crearPlantaButton.
  ///
  /// In en, this message translates to:
  /// **'Create Plant'**
  String get crearPlantaButton;

  /// No description provided for @deletePlantTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Plant'**
  String get deletePlantTitle;

  /// No description provided for @selectActivePlantToDelete.
  ///
  /// In en, this message translates to:
  /// **'Select an active plant to delete:'**
  String get selectActivePlantToDelete;

  /// No description provided for @activePlantsLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Plants'**
  String get activePlantsLabel;

  /// No description provided for @deletePlantButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Plant'**
  String get deletePlantButton;

  /// No description provided for @selectPlantToDelete.
  ///
  /// In en, this message translates to:
  /// **'Please select a plant to delete'**
  String get selectPlantToDelete;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the plant \"{plantName}\"?'**
  String confirmDeleteMessage(Object plantName);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @plantDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Plant deleted successfully'**
  String get plantDeletedMessage;

  /// No description provided for @noActivePlantTitle.
  ///
  /// In en, this message translates to:
  /// **'No active plant'**
  String get noActivePlantTitle;

  /// No description provided for @noActivePlantMessage.
  ///
  /// In en, this message translates to:
  /// **'No active plant detected.\n\nPlease create one before continuing.'**
  String get noActivePlantMessage;

  /// No description provided for @understood.
  ///
  /// In en, this message translates to:
  /// **'Understood'**
  String get understood;

  /// No description provided for @daysWithLife.
  ///
  /// In en, this message translates to:
  /// **'Days with life'**
  String get daysWithLife;

  /// No description provided for @plantName.
  ///
  /// In en, this message translates to:
  /// **'Indoor Plant'**
  String get plantName;

  /// No description provided for @viewPlantTips.
  ///
  /// In en, this message translates to:
  /// **'View Plant Tips'**
  String get viewPlantTips;

  /// No description provided for @drawer_header.
  ///
  /// In en, this message translates to:
  /// **'List of Options'**
  String get drawer_header;

  /// No description provided for @menu_create_plant.
  ///
  /// In en, this message translates to:
  /// **'Create Plant'**
  String get menu_create_plant;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Plant Creation'**
  String get title;

  /// No description provided for @menu_modify_plant.
  ///
  /// In en, this message translates to:
  /// **'Modify Plant'**
  String get menu_modify_plant;

  /// No description provided for @menu_delete_plant.
  ///
  /// In en, this message translates to:
  /// **'Delete Plant'**
  String get menu_delete_plant;

  /// No description provided for @menu_change_plant.
  ///
  /// In en, this message translates to:
  /// **'Change Plant'**
  String get menu_change_plant;

  /// No description provided for @menu_sensor_check.
  ///
  /// In en, this message translates to:
  /// **'Sensor Check'**
  String get menu_sensor_check;

  /// No description provided for @modifyPlantTitle.
  ///
  /// In en, this message translates to:
  /// **'Modify Plant'**
  String get modifyPlantTitle;

  /// No description provided for @selectPlantToModify.
  ///
  /// In en, this message translates to:
  /// **'Select an active plant to modify:'**
  String get selectPlantToModify;

  /// No description provided for @plantNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Name'**
  String get plantNameLabel;

  /// No description provided for @newPlantTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'New Plant Type'**
  String get newPlantTypeLabel;

  /// No description provided for @modifyPlantButton.
  ///
  /// In en, this message translates to:
  /// **'Modify Plant'**
  String get modifyPlantButton;

  /// No description provided for @selectPlantAndTypeMessage.
  ///
  /// In en, this message translates to:
  /// **'Please select a plant and a new type'**
  String get selectPlantAndTypeMessage;

  /// No description provided for @plantTypeModifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Plant type successfully modified'**
  String get plantTypeModifiedMessage;

  /// No description provided for @loadingState.
  ///
  /// In en, this message translates to:
  /// **'Loading state...'**
  String get loadingState;

  /// No description provided for @veryBadState.
  ///
  /// In en, this message translates to:
  /// **'Very poor condition'**
  String get veryBadState;

  /// No description provided for @badState.
  ///
  /// In en, this message translates to:
  /// **'Poor condition'**
  String get badState;

  /// No description provided for @regularState.
  ///
  /// In en, this message translates to:
  /// **'Fair condition'**
  String get regularState;

  /// No description provided for @goodState.
  ///
  /// In en, this message translates to:
  /// **'Good condition'**
  String get goodState;

  /// No description provided for @veryGoodState.
  ///
  /// In en, this message translates to:
  /// **'Very good condition'**
  String get veryGoodState;

  /// No description provided for @unknownState.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownState;

  /// No description provided for @healthStatus.
  ///
  /// In en, this message translates to:
  /// **'State of care: {percent}%'**
  String healthStatus(Object percent);

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Name'**
  String get nameLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Type'**
  String get typeLabel;

  /// No description provided for @plantDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Planting Date'**
  String get plantDateLabel;

  /// No description provided for @maxTempLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Temperature (°C)'**
  String get maxTempLabel;

  /// No description provided for @minTempLabel.
  ///
  /// In en, this message translates to:
  /// **'Min Temperature (°C)'**
  String get minTempLabel;

  /// No description provided for @maxHumidityLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Humidity (%)'**
  String get maxHumidityLabel;

  /// No description provided for @minHumidityLabel.
  ///
  /// In en, this message translates to:
  /// **'Min Humidity (%)'**
  String get minHumidityLabel;

  /// No description provided for @maxLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Light Hours (h)'**
  String get maxLightLabel;

  /// No description provided for @minLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Min Light Hours (h)'**
  String get minLightLabel;

  /// No description provided for @waterLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Water (ml)'**
  String get waterLabel;

  /// No description provided for @addPlantButton.
  ///
  /// In en, this message translates to:
  /// **'Add Plant'**
  String get addPlantButton;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter the plant name'**
  String get pleaseEnterName;

  /// No description provided for @tempMinGreaterThanMax.
  ///
  /// In en, this message translates to:
  /// **'Min temperature cannot be greater than max'**
  String get tempMinGreaterThanMax;

  /// No description provided for @humidityMinGreaterThanMax.
  ///
  /// In en, this message translates to:
  /// **'Min humidity cannot be greater than max'**
  String get humidityMinGreaterThanMax;

  /// No description provided for @lightMinGreaterThanMax.
  ///
  /// In en, this message translates to:
  /// **'Min light hours cannot be greater than max'**
  String get lightMinGreaterThanMax;

  /// No description provided for @plant_info.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}\nPlanting Date: {date}\nMax Temp: {maxTemp}°C\nMin Temp: {minTemp}°C\nMax Humidity: {maxHumidity}%\nMin Humidity: {minHumidity}%\nLight: {minLight}-{maxLight}h\nWater: {water}ml/day'**
  String plant_info(Object date, Object maxHumidity, Object maxLight, Object maxTemp, Object minHumidity, Object minLight, Object minTemp, Object type, Object water);

  /// No description provided for @plantaCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Plant created successfully'**
  String get plantaCreatedMessage;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'TOMATO'**
  String get welcomeMessage;

  /// No description provided for @plantStatus.
  ///
  /// In en, this message translates to:
  /// **'In good condition'**
  String get plantStatus;

  /// No description provided for @plantHealth.
  ///
  /// In en, this message translates to:
  /// **'Health Status: 75%'**
  String get plantHealth;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @appTitleplants.
  ///
  /// In en, this message translates to:
  /// **'Plant Tips'**
  String get appTitleplants;

  /// No description provided for @screenTitleplants.
  ///
  /// In en, this message translates to:
  /// **'Plant Tips'**
  String get screenTitleplants;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not fetch plant tips'**
  String get errorMessage;

  /// No description provided for @unitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit: {unit}'**
  String unitLabel(Object unit);

  /// No description provided for @appTitlesensors.
  ///
  /// In en, this message translates to:
  /// **'Active Sensors'**
  String get appTitlesensors;

  /// No description provided for @screenTitlesensors.
  ///
  /// In en, this message translates to:
  /// **'Active Sensors'**
  String get screenTitlesensors;

  /// No description provided for @errorMessagesensors.
  ///
  /// In en, this message translates to:
  /// **'Could not fetch sensors'**
  String get errorMessagesensors;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model: {model}'**
  String modelLabel(Object model);

  /// No description provided for @typeLabelsensors.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String typeLabelsensors(Object type);

  /// No description provided for @readingLabel.
  ///
  /// In en, this message translates to:
  /// **'Reading: {reading} {unit}'**
  String readingLabel(Object reading, Object unit);

  /// No description provided for @pleaseEnterAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please enter all fields.'**
  String get pleaseEnterAllFields;

  /// No description provided for @plantCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Plant created successfully!'**
  String get plantCreatedSuccess;

  /// No description provided for @errorCreatingPlant.
  ///
  /// In en, this message translates to:
  /// **'Error creating plant'**
  String get errorCreatingPlant;

  /// No description provided for @errorConnectingToServer.
  ///
  /// In en, this message translates to:
  /// **'Error connecting to the server.'**
  String get errorConnectingToServer;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
