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

  static String m0(min, max) => "Min Hours: ${min}, Max Hours: ${max}";

  static String m1(type) => "Measurement Type: ${type}";

  static String m2(model) => "Model: ${model}";

  static String m3(type, date, maxTemp, minTemp, maxHumidity, minHumidity,
          minLight, maxLight, water) =>
      "Type: ${type}\nPlanting Date: ${date}\nMax Temp: ${maxTemp}°C\nMin Temp: ${minTemp}°C\nMax Humidity: ${maxHumidity}%\nMin Humidity: ${minHumidity}%\nLight: ${minLight}-${maxLight}h\nWater: ${water}ml/day";

  static String m4(min, max) => "Range: ${min} - ${max}";

  static String m5(reading, unit) => "Reading: ${reading} ${unit}";

  static String m6(type) => "Type: ${type}";

  static String m7(unit) => "Unit: ${unit}";

  static String m8(zone) => "Zone: ${zone}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "MainTitle": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
        "MaterialApp": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
        "PantallaMain": MessageLookupByLibrary.simpleMessage("1.0"),
        "addPlantButton": MessageLookupByLibrary.simpleMessage("Add Plant"),
        "appTitleplants": MessageLookupByLibrary.simpleMessage("Plant Tips"),
        "appTitlesensors":
            MessageLookupByLibrary.simpleMessage("Active Sensors"),
        "change_language": MessageLookupByLibrary.simpleMessage("Language"),
        "completeFieldsMessage":
            MessageLookupByLibrary.simpleMessage("Please complete all fields"),
        "crearPlantaButton":
            MessageLookupByLibrary.simpleMessage("Create Plant"),
        "createNewTipoPlanta":
            MessageLookupByLibrary.simpleMessage("Create a new plant type"),
        "daysWithLife": MessageLookupByLibrary.simpleMessage("Days with life"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "descripcionPlantaLabel":
            MessageLookupByLibrary.simpleMessage("Plant Type Description"),
        "drawer_header":
            MessageLookupByLibrary.simpleMessage("List of Options"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "errorConnectingToServer": MessageLookupByLibrary.simpleMessage(
            "Error connecting to the server."),
        "errorCreatingPlant":
            MessageLookupByLibrary.simpleMessage("Error creating plant"),
        "errorMessage":
            MessageLookupByLibrary.simpleMessage("Could not fetch plant tips"),
        "errorMessagesensors":
            MessageLookupByLibrary.simpleMessage("Could not fetch sensors"),
        "graphs": MessageLookupByLibrary.simpleMessage("Graphs"),
        "guardarTipoPlantaButton":
            MessageLookupByLibrary.simpleMessage("Save Plant Type"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hoursLabel": m0,
        "humidityMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min humidity cannot be greater than max"),
        "lightMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min light hours cannot be greater than max"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "maxHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Max Humidity (%)"),
        "maxLightLabel":
            MessageLookupByLibrary.simpleMessage("Max Light Hours (h)"),
        "maxTempLabel":
            MessageLookupByLibrary.simpleMessage("Max Temperature (°C)"),
        "measurementTypeLabel": m1,
        "menu_create_plant":
            MessageLookupByLibrary.simpleMessage("Create Plant"),
        "menu_delete_plant":
            MessageLookupByLibrary.simpleMessage("Delete Plant"),
        "menu_modify_plant":
            MessageLookupByLibrary.simpleMessage("Modify Plant"),
        "menu_sensor_check":
            MessageLookupByLibrary.simpleMessage("Sensor Check"),
        "milestones": MessageLookupByLibrary.simpleMessage("Milestones"),
        "minHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Min Humidity (%)"),
        "minLightLabel":
            MessageLookupByLibrary.simpleMessage("Min Light Hours (h)"),
        "minTempLabel":
            MessageLookupByLibrary.simpleMessage("Min Temperature (°C)"),
        "modelLabel": m2,
        "nameLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
        "nombrePlantaLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
        "nombreTipoPlantaLabel":
            MessageLookupByLibrary.simpleMessage("Plant Type Name"),
        "plantCreatedSuccess":
            MessageLookupByLibrary.simpleMessage("Plant created successfully!"),
        "plantDateLabel": MessageLookupByLibrary.simpleMessage("Planting Date"),
        "plantHealth":
            MessageLookupByLibrary.simpleMessage("Health Status: 75%"),
        "plantName": MessageLookupByLibrary.simpleMessage("Indoor Plant"),
        "plantStatus":
            MessageLookupByLibrary.simpleMessage("In good condition"),
        "plant_info": m3,
        "plantaCreatedMessage":
            MessageLookupByLibrary.simpleMessage("Plant created successfully"),
        "pleaseEnterAllFields":
            MessageLookupByLibrary.simpleMessage("Please enter all fields."),
        "pleaseEnterName":
            MessageLookupByLibrary.simpleMessage("Please enter the plant name"),
        "rangeLabel": m4,
        "readingLabel": m5,
        "screenTitleplants": MessageLookupByLibrary.simpleMessage("Plant Tips"),
        "screenTitlesensors":
            MessageLookupByLibrary.simpleMessage("Active Sensors"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "spanish": MessageLookupByLibrary.simpleMessage("Spanish"),
        "step1Title": MessageLookupByLibrary.simpleMessage(
            "Step 1: Select or Create Plant Type"),
        "step2Title":
            MessageLookupByLibrary.simpleMessage("Step 2: Create Plant"),
        "tempMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min temperature cannot be greater than max"),
        "tipoPlantaCreatedMessage": MessageLookupByLibrary.simpleMessage(
            "Plant type created successfully"),
        "tipoPlantaLabel": MessageLookupByLibrary.simpleMessage("Plant Type"),
        "title": MessageLookupByLibrary.simpleMessage("Plant Creation"),
        "typeLabel": MessageLookupByLibrary.simpleMessage("Plant Type"),
        "typeLabelsensors": m6,
        "unitLabel": m7,
        "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
        "viewPlantTips":
            MessageLookupByLibrary.simpleMessage("View Plant Tips"),
        "waterLabel": MessageLookupByLibrary.simpleMessage("Daily Water (ml)"),
        "welcomeMessage": MessageLookupByLibrary.simpleMessage("TOMATO"),
        "zoneLabel": m8
      };
}
