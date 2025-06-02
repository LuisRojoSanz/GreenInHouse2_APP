// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(plantName) =>
      "Are you sure you want to delete the plant \"${plantName}\"?";

  static String m1(count) => "${count} days";

  static String m2(percent) => "State of care: ${percent}%";

  static String m3(min, max) => "Min Hours: ${min}, Max Hours: ${max}";

  static String m4(type) => "Measurement Type: ${type}";

  static String m5(model) => "Model: ${model}";

  static String m6(text) => "Tip: ${text}";

  static String m7(
    type,
    date,
    maxTemp,
    minTemp,
    maxHumidity,
    minHumidity,
    minLight,
    maxLight,
    water,
  ) =>
      "Type: ${type}\nPlanting Date: ${date}\nMax Temp: ${maxTemp}°C\nMin Temp: ${minTemp}°C\nMax Humidity: ${maxHumidity}%\nMin Humidity: ${minHumidity}%\nLight: ${minLight}-${maxLight}h\nWater: ${water}ml/day";

  static String m8(min, max) => "Range: ${min} - ${max}";

  static String m9(reading, unit) => "Reading: ${reading} ${unit}";

  static String m10(type) => "Type: ${type}";

  static String m11(unit) => "Unit: ${unit}";

  static String m12(zone) => "Zone: ${zone}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "MainTitle": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
    "MaterialApp": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
    "PantallaMain": MessageLookupByLibrary.simpleMessage("1.0"),
    "accept": MessageLookupByLibrary.simpleMessage("Accept"),
    "activePlantsLabel": MessageLookupByLibrary.simpleMessage("Active Plants"),
    "activeSensors": MessageLookupByLibrary.simpleMessage("Active Sensors"),
    "addPlantButton": MessageLookupByLibrary.simpleMessage("Add Plant"),
    "airHumidityHigh": MessageLookupByLibrary.simpleMessage(
      "Reduce humidity, ventilate the area.",
    ),
    "airHumidityLow": MessageLookupByLibrary.simpleMessage(
      "Increase air humidity, place a humidifier nearby.",
    ),
    "airHumidityOptimal": MessageLookupByLibrary.simpleMessage(
      "Air humidity is in the optimal range.",
    ),
    "ambienthumiditySensor": MessageLookupByLibrary.simpleMessage(
      "AMBIENT HUMIDITY",
    ),
    "appTitleplants": MessageLookupByLibrary.simpleMessage("Plant Tips"),
    "appTitlesensors": MessageLookupByLibrary.simpleMessage("Active Sensors"),
    "areYouSureRemovePhoto": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove the photo?",
    ),
    "badState": MessageLookupByLibrary.simpleMessage("Poor condition"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "change_language": MessageLookupByLibrary.simpleMessage("Language"),
    "chooseFromGallery": MessageLookupByLibrary.simpleMessage(
      "Choose from gallery",
    ),
    "completeFieldsMessage": MessageLookupByLibrary.simpleMessage(
      "Please complete all fields",
    ),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirmDeleteMessage": m0,
    "confirmDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Deletion",
    ),
    "confirmFertilizerQuestion": MessageLookupByLibrary.simpleMessage(
      "Have you added fertilizer to the plant?",
    ),
    "confirmFertilizerTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm fertilizer",
    ),
    "confirmPhotoRemoval": MessageLookupByLibrary.simpleMessage(
      "Confirm removal",
    ),
    "confirmSoilChangeQuestion": MessageLookupByLibrary.simpleMessage(
      "Have you changed the plant\'s soil?",
    ),
    "confirmSoilChangeTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm soil change",
    ),
    "crearPlantaButton": MessageLookupByLibrary.simpleMessage("Create Plant"),
    "createNewTipoPlanta": MessageLookupByLibrary.simpleMessage(
      "Create a new plant type",
    ),
    "dailyMilestones": MessageLookupByLibrary.simpleMessage("Daily Milestones"),
    "dateTimeAxis": MessageLookupByLibrary.simpleMessage("Date and Time"),
    "daysBack": MessageLookupByLibrary.simpleMessage("Days back:"),
    "daysCount": m1,
    "daysWithLife": MessageLookupByLibrary.simpleMessage("Days with life"),
    "degrees": MessageLookupByLibrary.simpleMessage("Temperature (ºC)"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deletePlantButton": MessageLookupByLibrary.simpleMessage("Delete Plant"),
    "deletePlantTitle": MessageLookupByLibrary.simpleMessage("Delete Plant"),
    "descripcionPlantaLabel": MessageLookupByLibrary.simpleMessage(
      "Plant Type Description",
    ),
    "drawer_header": MessageLookupByLibrary.simpleMessage("List of Options"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "errorConnectingToServer": MessageLookupByLibrary.simpleMessage(
      "Error connecting to the server.",
    ),
    "errorCreatingPlant": MessageLookupByLibrary.simpleMessage(
      "Error creating plant",
    ),
    "errorFetchingData": MessageLookupByLibrary.simpleMessage(
      "No data retrieved",
    ),
    "errorMessage": MessageLookupByLibrary.simpleMessage(
      "Could not fetch plant tips",
    ),
    "errorMessagesensors": MessageLookupByLibrary.simpleMessage(
      "Could not fetch sensors",
    ),
    "fertilizerFrequency": MessageLookupByLibrary.simpleMessage(
      "⏳ Fertilizer frequency (days)",
    ),
    "fertilizerInLessThanMonth": MessageLookupByLibrary.simpleMessage(
      "Less than a month to add fertilizer again",
    ),
    "fertilizerOverdue": MessageLookupByLibrary.simpleMessage(
      "Add fertilizer, the scheduled time has passed",
    ),
    "fertilizerRecentlyAdded": MessageLookupByLibrary.simpleMessage(
      "Fertilizer recently added.",
    ),
    "goodState": MessageLookupByLibrary.simpleMessage("Good condition"),
    "graphAmbientHumidity": MessageLookupByLibrary.simpleMessage(
      "Ambient Humidity Graph",
    ),
    "graphLight": MessageLookupByLibrary.simpleMessage("Light Graph"),
    "graphSoilMoisture": MessageLookupByLibrary.simpleMessage(
      "Soil Moisture Graph",
    ),
    "graphTemperature": MessageLookupByLibrary.simpleMessage(
      "Temperature Graph",
    ),
    "graphs": MessageLookupByLibrary.simpleMessage("Graphs"),
    "guardarTipoPlantaButton": MessageLookupByLibrary.simpleMessage(
      "Save Plant Type",
    ),
    "healthStatus": m2,
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hoursLabel": m3,
    "humidityMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
      "Min humidity cannot be greater than max",
    ),
    "humiditySensor": MessageLookupByLibrary.simpleMessage("HUMIDITY"),
    "lastReading": MessageLookupByLibrary.simpleMessage("Last reading"),
    "lightHigh": MessageLookupByLibrary.simpleMessage(
      "The plant is getting too much light, place it in the shade.",
    ),
    "lightLow": MessageLookupByLibrary.simpleMessage(
      "The plant needs more light, move it to a brighter spot.",
    ),
    "lightMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
      "Min light hours cannot be greater than max",
    ),
    "lightOptimal": MessageLookupByLibrary.simpleMessage(
      "Light levels are in the optimal range.",
    ),
    "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loadingState": MessageLookupByLibrary.simpleMessage("Loading state..."),
    "luminositySensor": MessageLookupByLibrary.simpleMessage("LUMINOSITY"),
    "lux": MessageLookupByLibrary.simpleMessage("Lux"),
    "maxHumidityLabel": MessageLookupByLibrary.simpleMessage(
      "Max Humidity (%)",
    ),
    "maxLightLabel": MessageLookupByLibrary.simpleMessage(
      "Max Light Hours (h)",
    ),
    "maxTempLabel": MessageLookupByLibrary.simpleMessage(
      "Max Temperature (°C)",
    ),
    "measurementTypeLabel": m4,
    "menu_create_plant": MessageLookupByLibrary.simpleMessage("Create Plant"),
    "menu_delete_plant": MessageLookupByLibrary.simpleMessage("Delete Plant"),
    "menu_modify_plant": MessageLookupByLibrary.simpleMessage("Modify Plant"),
    "menu_sensor_check": MessageLookupByLibrary.simpleMessage("Sensor Check"),
    "milestoneAmbientHumidity": MessageLookupByLibrary.simpleMessage(
      "Ambient Humidity",
    ),
    "milestoneFertilizer": MessageLookupByLibrary.simpleMessage("Fertilizer"),
    "milestoneLight": MessageLookupByLibrary.simpleMessage("Light"),
    "milestoneSoilChange": MessageLookupByLibrary.simpleMessage("Soil Change"),
    "milestoneSoilMoisture": MessageLookupByLibrary.simpleMessage(
      "Soil Moisture",
    ),
    "milestoneTemperature": MessageLookupByLibrary.simpleMessage("Temperature"),
    "milestones": MessageLookupByLibrary.simpleMessage("Milestones"),
    "milestonesProgress": MessageLookupByLibrary.simpleMessage(
      "Milestone Progress",
    ),
    "milestonesTitle": MessageLookupByLibrary.simpleMessage("Milestones"),
    "minHumidityLabel": MessageLookupByLibrary.simpleMessage(
      "Min Humidity (%)",
    ),
    "minLightLabel": MessageLookupByLibrary.simpleMessage(
      "Min Light Hours (h)",
    ),
    "minTempLabel": MessageLookupByLibrary.simpleMessage(
      "Min Temperature (°C)",
    ),
    "model": MessageLookupByLibrary.simpleMessage("Model"),
    "modelLabel": m5,
    "modifyPlantButton": MessageLookupByLibrary.simpleMessage("Modify Plant"),
    "modifyPlantTitle": MessageLookupByLibrary.simpleMessage("Modify Plant"),
    "monthlyMilestones": MessageLookupByLibrary.simpleMessage(
      "Monthly Milestones",
    ),
    "nameLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
    "newPlantFertilizerMessage": MessageLookupByLibrary.simpleMessage(
      "New plant created, fertilizer is needed",
    ),
    "newPlantSoilMessage": MessageLookupByLibrary.simpleMessage(
      "Newly created plant, mark if soil change is done",
    ),
    "newPlantTypeLabel": MessageLookupByLibrary.simpleMessage("New Plant Type"),
    "nextApplication": MessageLookupByLibrary.simpleMessage("Next application"),
    "nextChange": MessageLookupByLibrary.simpleMessage("Next change"),
    "noActivePlantMessage": MessageLookupByLibrary.simpleMessage(
      "No active plant detected.\n\nPlease create one before continuing.",
    ),
    "noActivePlantTitle": MessageLookupByLibrary.simpleMessage(
      "No active plant",
    ),
    "noConnectionAccept": MessageLookupByLibrary.simpleMessage("OK"),
    "noConnectionMessage": MessageLookupByLibrary.simpleMessage(
      "Could not connect to the server.\nPlease check your network and ensure the smart pot is powered on and connected to Wi-Fi.",
    ),
    "noConnectionTitle": MessageLookupByLibrary.simpleMessage("No connection"),
    "noData": MessageLookupByLibrary.simpleMessage("No data available"),
    "noReading": MessageLookupByLibrary.simpleMessage("No reading"),
    "noUnit": MessageLookupByLibrary.simpleMessage("No unit"),
    "nombrePlantaLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
    "nombreTipoPlantaLabel": MessageLookupByLibrary.simpleMessage(
      "Plant Type Name",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "percentageAxis": MessageLookupByLibrary.simpleMessage("Percentage (%)"),
    "photoNeedsPlant": MessageLookupByLibrary.simpleMessage(
      "You must create a plant before adding a photo",
    ),
    "plantCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Plant created successfully!",
    ),
    "plantDateLabel": MessageLookupByLibrary.simpleMessage("Planting Date"),
    "plantDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Plant deleted successfully",
    ),
    "plantHealth": MessageLookupByLibrary.simpleMessage("Health Status: 75%"),
    "plantName": MessageLookupByLibrary.simpleMessage("Indoor Plant"),
    "plantNameLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
    "plantStatus": MessageLookupByLibrary.simpleMessage("In good condition"),
    "plantTipDescription": m6,
    "plantTypeModifiedMessage": MessageLookupByLibrary.simpleMessage(
      "Plant type successfully modified",
    ),
    "plant_info": m7,
    "plantaCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Plant created successfully",
    ),
    "pleaseEnterAllFields": MessageLookupByLibrary.simpleMessage(
      "Please enter all fields.",
    ),
    "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
      "Please enter the plant name",
    ),
    "rangeLabel": m8,
    "readingLabel": m9,
    "recentSoilChange": MessageLookupByLibrary.simpleMessage(
      "Recent soil change, all good.",
    ),
    "regularState": MessageLookupByLibrary.simpleMessage("Fair condition"),
    "removePhoto": MessageLookupByLibrary.simpleMessage("Remove photo"),
    "screenTitlePlantTips": MessageLookupByLibrary.simpleMessage(
      "Plant care tips",
    ),
    "screenTitleplants": MessageLookupByLibrary.simpleMessage("Plant Tips"),
    "screenTitlesensors": MessageLookupByLibrary.simpleMessage(
      "Active Sensors",
    ),
    "selectActivePlantToDelete": MessageLookupByLibrary.simpleMessage(
      "Select an active plant to delete:",
    ),
    "selectDays": MessageLookupByLibrary.simpleMessage("Select days"),
    "selectPlantAndTypeMessage": MessageLookupByLibrary.simpleMessage(
      "Please select a plant and a new type",
    ),
    "selectPlantToDelete": MessageLookupByLibrary.simpleMessage(
      "Please select a plant to delete",
    ),
    "selectPlantToModify": MessageLookupByLibrary.simpleMessage(
      "Select an active plant to modify:",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "showGraphs": MessageLookupByLibrary.simpleMessage("📊 Show graphs"),
    "showMilestones": MessageLookupByLibrary.simpleMessage("✨ Show Milestones"),
    "soilChangeFrequency": MessageLookupByLibrary.simpleMessage(
      "⏳ Soil change frequency (days)",
    ),
    "soilChangeInLessThanMonth": MessageLookupByLibrary.simpleMessage(
      "Less than a month left for the next soil change",
    ),
    "soilChangeOverdue": MessageLookupByLibrary.simpleMessage(
      "Change the plant\'s soil, the scheduled time has passed.",
    ),
    "soilMoistureHigh": MessageLookupByLibrary.simpleMessage(
      "Don\'t water it more, the soil is too wet.",
    ),
    "soilMoistureLow": MessageLookupByLibrary.simpleMessage(
      "Water the plant, it needs more moisture.",
    ),
    "soilMoistureOptimal": MessageLookupByLibrary.simpleMessage(
      "Soil moisture is in the optimal range.",
    ),
    "soonToAdd": MessageLookupByLibrary.simpleMessage("Soon to add"),
    "soonToChange": MessageLookupByLibrary.simpleMessage("Soon to change"),
    "spanish": MessageLookupByLibrary.simpleMessage("Spanish"),
    "step1Title": MessageLookupByLibrary.simpleMessage(
      "Step 1: Select or Create Plant Type",
    ),
    "step2Title": MessageLookupByLibrary.simpleMessage("Step 2: Create Plant"),
    "takePhoto": MessageLookupByLibrary.simpleMessage("Take photo"),
    "tapToAddPhoto": MessageLookupByLibrary.simpleMessage("Tap to add photo"),
    "tempMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
      "Min temperature cannot be greater than max",
    ),
    "temperatureHigh": MessageLookupByLibrary.simpleMessage(
      "It\'s too hot, keep the plant away from direct sunlight.",
    ),
    "temperatureLow": MessageLookupByLibrary.simpleMessage(
      "It\'s too cold, move the plant to a warmer place.",
    ),
    "temperatureOptimal": MessageLookupByLibrary.simpleMessage(
      "Temperature is in the optimal range.",
    ),
    "temperatureSensor": MessageLookupByLibrary.simpleMessage("TEMPERATURE"),
    "tipoPlantaCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Plant type created successfully",
    ),
    "tipoPlantaLabel": MessageLookupByLibrary.simpleMessage("Plant Type"),
    "title": MessageLookupByLibrary.simpleMessage("Plant Creation"),
    "type": MessageLookupByLibrary.simpleMessage("Type"),
    "typeLabel": MessageLookupByLibrary.simpleMessage("Plant Type"),
    "typeLabelsensors": m10,
    "understood": MessageLookupByLibrary.simpleMessage("Understood"),
    "unitLabel": m11,
    "unknownModel": MessageLookupByLibrary.simpleMessage("Unknown model"),
    "unknownName": MessageLookupByLibrary.simpleMessage("Unknown name"),
    "unknownState": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownType": MessageLookupByLibrary.simpleMessage("Unknown type"),
    "unknownZone": MessageLookupByLibrary.simpleMessage("Unspecified zone"),
    "updateGraph": MessageLookupByLibrary.simpleMessage("Update Graph"),
    "veryBadState": MessageLookupByLibrary.simpleMessage("Very poor condition"),
    "veryGoodState": MessageLookupByLibrary.simpleMessage(
      "Very good condition",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "viewPlantTips": MessageLookupByLibrary.simpleMessage("View Plant Tips"),
    "waterLabel": MessageLookupByLibrary.simpleMessage("Daily Water (ml)"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage("TOMATO"),
    "withOutData": MessageLookupByLibrary.simpleMessage("No data"),
    "yesAdded": MessageLookupByLibrary.simpleMessage("Yes, I did"),
    "yesChanged": MessageLookupByLibrary.simpleMessage("Yes, I changed it"),
    "yesRemove": MessageLookupByLibrary.simpleMessage("Yes, remove"),
    "zone": MessageLookupByLibrary.simpleMessage("Zone"),
    "zoneLabel": m12,
  };
}
