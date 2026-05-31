// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get materialApp => 'GreenInHouse_2';

  @override
  String get pantallaMain => '1.0';

  @override
  String get mainTitle => 'GreenInHouse_2';

  @override
  String get graphs => 'Graphs';

  @override
  String get milestones => 'Milestones';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get screenTitlePlantTips => 'Plant care tips';

  @override
  String plantTipDescription(Object text) {
    return 'Tip: $text';
  }

  @override
  String zoneLabel(Object zone) {
    return 'Zone: $zone';
  }

  @override
  String measurementTypeLabel(Object type) {
    return 'Measurement Type: $type';
  }

  @override
  String rangeLabel(Object max, Object min) {
    return 'Range: $min - $max';
  }

  @override
  String hoursLabel(Object max, Object min) {
    return 'Min Hours: $min, Max Hours: $max';
  }

  @override
  String get noConnectionTitle => 'No connection';

  @override
  String get noConnectionMessage => 'Could not connect to the server.\nPlease check your network and ensure the smart pot is powered on and connected to Wi-Fi.';

  @override
  String get noConnectionAccept => 'OK';

  @override
  String get selectDays => 'Select days';

  @override
  String get selectDate => 'Select dates';

  @override
  String get accept => 'Accept';

  @override
  String get daysBack => 'Days back:';

  @override
  String get updateGraph => 'Update Graph';

  @override
  String get noData => 'No data available';

  @override
  String get dateTimeAxis => 'Date and Time';

  @override
  String get percentageAxis => 'Percentage (%)';

  @override
  String daysCount(Object count) {
    return '$count days';
  }

  @override
  String get lux => 'Lux';

  @override
  String get degrees => 'Temperature (ºC)';

  @override
  String get humiditySensor => 'HUMIDITY';

  @override
  String get ambienthumiditySensor => 'AMBIENT HUMIDITY';

  @override
  String get luminositySensor => 'LUMINOSITY';

  @override
  String get temperatureSensor => 'TEMPERATURE';

  @override
  String get loadingMessage => 'Loading...';

  @override
  String get completed => 'Completed';

  @override
  String get pending => 'Pending';

  @override
  String get cancel => 'Cancel';

  @override
  String get soilMoistureLow => 'Water the plant, it needs more moisture.';

  @override
  String get soilMoistureHigh => 'Don\'t water it more, the soil is too wet.';

  @override
  String get soilMoistureOptimal => 'Soil moisture is in the optimal range.';

  @override
  String get airHumidityLow => 'Increase air humidity, place a humidifier nearby.';

  @override
  String get airHumidityHigh => 'Reduce humidity, ventilate the area.';

  @override
  String get airHumidityOptimal => 'Air humidity is in the optimal range.';

  @override
  String get lightLow => 'The plant needs more light, move it to a brighter spot.';

  @override
  String get lightHigh => 'The plant is getting too much light, place it in the shade.';

  @override
  String get lightOptimal => 'Light levels are in the optimal range.';

  @override
  String get temperatureLow => 'It\'s too cold, move the plant to a warmer place.';

  @override
  String get temperatureHigh => 'It\'s too hot, keep the plant away from direct sunlight.';

  @override
  String get temperatureOptimal => 'Temperature is in the optimal range.';

  @override
  String get milestonesTitle => 'Milestones';

  @override
  String get milestonesProgress => 'Milestone Progress';

  @override
  String get dailyMilestones => 'Daily Milestones';

  @override
  String get monthlyMilestones => 'Monthly Milestones';

  @override
  String get soonToChange => 'Soon to change';

  @override
  String get soonToAdd => 'Soon to add';

  @override
  String get recentSoilChange => 'Recent soil change, all good.';

  @override
  String get soilChangeInLessThanMonth => 'Less than a month left for the next soil change';

  @override
  String get soilChangeOverdue => 'Change the plant\'s soil, the scheduled time has passed.';

  @override
  String get nextChange => 'Next change';

  @override
  String get confirmSoilChangeTitle => 'Confirm soil change';

  @override
  String get confirmSoilChangeQuestion => 'Have you changed the plant\'s soil?';

  @override
  String get yesChanged => 'Yes, I changed it';

  @override
  String get fertilizerRecentlyAdded => 'Fertilizer recently added.';

  @override
  String get fertilizerInLessThanMonth => 'Less than a month to add fertilizer again';

  @override
  String get fertilizerOverdue => 'Add fertilizer, the scheduled time has passed';

  @override
  String get nextApplication => 'Next application';

  @override
  String get confirmFertilizerTitle => 'Confirm fertilizer';

  @override
  String get confirmFertilizerQuestion => 'Have you added fertilizer to the plant?';

  @override
  String get yesAdded => 'Yes, I did';

  @override
  String get newPlantFertilizerMessage => 'New plant created, fertilizer is needed';

  @override
  String get newPlantSoilMessage => 'Newly created plant, mark if soil change is done';

  @override
  String get photoNeedsPlant => 'You must create a plant before adding a photo';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get confirmPhotoRemoval => 'Confirm removal';

  @override
  String get areYouSureRemovePhoto => 'Are you sure you want to remove the photo?';

  @override
  String get yesRemove => 'Yes, remove';

  @override
  String get tapToAddPhoto => 'Tap to add photo';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get showGraphs => '📊 Show graphs';

  @override
  String get graphSoilMoisture => 'Soil Moisture Graph';

  @override
  String get graphAmbientHumidity => 'Ambient Humidity Graph';

  @override
  String get graphLight => 'Light Graph';

  @override
  String get graphTemperature => 'Temperature Graph';

  @override
  String get showMilestones => '✨ Show Milestones';

  @override
  String get milestoneSoilMoisture => 'Soil Moisture';

  @override
  String get milestoneAmbientHumidity => 'Ambient Humidity';

  @override
  String get milestoneLight => 'Light';

  @override
  String get milestoneTemperature => 'Temperature';

  @override
  String get milestoneSoilChange => 'Soil Change';

  @override
  String get milestoneFertilizer => 'Fertilizer';

  @override
  String get soilChangeFrequency => '⏳ Soil change frequency (days)';

  @override
  String get fertilizerFrequency => '⏳ Fertilizer frequency (days)';

  @override
  String get change_language => 'Language';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get activeSensors => 'Active Sensors';

  @override
  String get errorFetchingData => 'No data retrieved';

  @override
  String get withOutData => 'No data';

  @override
  String get unknownName => 'Unknown name';

  @override
  String get unknownModel => 'Unknown model';

  @override
  String get unknownType => 'Unknown type';

  @override
  String get unknownZone => 'Unspecified zone';

  @override
  String get noReading => 'No reading';

  @override
  String get noUnit => 'No unit';

  @override
  String get model => 'Model';

  @override
  String get type => 'Type';

  @override
  String get zone => 'Zone';

  @override
  String get lastReading => 'Last reading';

  @override
  String get completeFieldsMessage => 'Please complete all fields';

  @override
  String get tipoPlantaCreatedMessage => 'Plant type created successfully';

  @override
  String get step1Title => 'Step 1: Select or Create Plant Type';

  @override
  String get tipoPlantaLabel => 'Plant Type';

  @override
  String get createNewTipoPlanta => 'Create a new plant type';

  @override
  String get nombreTipoPlantaLabel => 'Plant Type Name';

  @override
  String get descripcionPlantaLabel => 'Plant Type Description';

  @override
  String get guardarTipoPlantaButton => 'Save Plant Type';

  @override
  String get step2Title => 'Step 2: Create Plant';

  @override
  String get nombrePlantaLabel => 'Plant Name';

  @override
  String get crearPlantaButton => 'Create Plant';

  @override
  String get deletePlantTitle => 'Delete Plant';

  @override
  String get selectActivePlantToDelete => 'Select an active plant to delete:';

  @override
  String get activePlantsLabel => 'Active Plants';

  @override
  String get deletePlantButton => 'Delete Plant';

  @override
  String get selectPlantToDelete => 'Please select a plant to delete';

  @override
  String get confirmDeleteTitle => 'Confirm Deletion';

  @override
  String confirmDeleteMessage(Object plantName) {
    return 'Are you sure you want to delete the plant \"$plantName\"?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get plantDeletedMessage => 'Plant deleted successfully';

  @override
  String get noActivePlantTitle => 'No active plant';

  @override
  String get noActivePlantMessage => 'No active plant detected.\n\nPlease create one before continuing.';

  @override
  String get understood => 'Understood';

  @override
  String get daysWithLife => 'Days with life';

  @override
  String get plantName => 'Indoor Plant';

  @override
  String get viewPlantTips => 'View Plant Tips';

  @override
  String get drawer_header => 'List of Options';

  @override
  String get menu_create_plant => 'Create Plant';

  @override
  String get title => 'Plant Creation';

  @override
  String get menu_modify_plant => 'Modify Plant';

  @override
  String get menu_delete_plant => 'Delete Plant';

  @override
  String get menu_change_plant => 'Change Plant';

  @override
  String get menu_sensor_check => 'Sensor Check';

  @override
  String get modifyPlantTitle => 'Modify Plant';

  @override
  String get selectPlantToModify => 'Select an active plant to modify:';

  @override
  String get plantNameLabel => 'Plant Name';

  @override
  String get newPlantTypeLabel => 'New Plant Type';

  @override
  String get modifyPlantButton => 'Modify Plant';

  @override
  String get selectPlantAndTypeMessage => 'Please select a plant and a new type';

  @override
  String get plantTypeModifiedMessage => 'Plant type successfully modified';

  @override
  String get loadingState => 'Loading state...';

  @override
  String get veryBadState => 'Very poor condition';

  @override
  String get badState => 'Poor condition';

  @override
  String get regularState => 'Fair condition';

  @override
  String get goodState => 'Good condition';

  @override
  String get veryGoodState => 'Very good condition';

  @override
  String get unknownState => 'Unknown';

  @override
  String healthStatus(Object percent) {
    return 'State of care: $percent%';
  }

  @override
  String get nameLabel => 'Plant Name';

  @override
  String get typeLabel => 'Plant Type';

  @override
  String get plantDateLabel => 'Planting Date';

  @override
  String get maxTempLabel => 'Max Temperature (°C)';

  @override
  String get minTempLabel => 'Min Temperature (°C)';

  @override
  String get maxHumidityLabel => 'Max Humidity (%)';

  @override
  String get minHumidityLabel => 'Min Humidity (%)';

  @override
  String get maxLightLabel => 'Max Light Hours (h)';

  @override
  String get minLightLabel => 'Min Light Hours (h)';

  @override
  String get waterLabel => 'Daily Water (ml)';

  @override
  String get addPlantButton => 'Add Plant';

  @override
  String get pleaseEnterName => 'Please enter the plant name';

  @override
  String get tempMinGreaterThanMax => 'Min temperature cannot be greater than max';

  @override
  String get humidityMinGreaterThanMax => 'Min humidity cannot be greater than max';

  @override
  String get lightMinGreaterThanMax => 'Min light hours cannot be greater than max';

  @override
  String plant_info(Object date, Object maxHumidity, Object maxLight, Object maxTemp, Object minHumidity, Object minLight, Object minTemp, Object type, Object water) {
    return 'Type: $type\nPlanting Date: $date\nMax Temp: $maxTemp°C\nMin Temp: $minTemp°C\nMax Humidity: $maxHumidity%\nMin Humidity: $minHumidity%\nLight: $minLight-${maxLight}h\nWater: ${water}ml/day';
  }

  @override
  String get plantaCreatedMessage => 'Plant created successfully';

  @override
  String get welcomeMessage => 'TOMATO';

  @override
  String get plantStatus => 'In good condition';

  @override
  String get plantHealth => 'Health Status: 75%';

  @override
  String get viewDetails => 'View Details';

  @override
  String get appTitleplants => 'Plant Tips';

  @override
  String get screenTitleplants => 'Plant Tips';

  @override
  String get errorMessage => 'Could not fetch plant tips';

  @override
  String unitLabel(Object unit) {
    return 'Unit: $unit';
  }

  @override
  String get appTitlesensors => 'Active Sensors';

  @override
  String get screenTitlesensors => 'Active Sensors';

  @override
  String get errorMessagesensors => 'Could not fetch sensors';

  @override
  String modelLabel(Object model) {
    return 'Model: $model';
  }

  @override
  String typeLabelsensors(Object type) {
    return 'Type: $type';
  }

  @override
  String readingLabel(Object reading, Object unit) {
    return 'Reading: $reading $unit';
  }

  @override
  String get pleaseEnterAllFields => 'Please enter all fields.';

  @override
  String get plantCreatedSuccess => 'Plant created successfully!';

  @override
  String get errorCreatingPlant => 'Error creating plant';

  @override
  String get errorConnectingToServer => 'Error connecting to the server.';
}
