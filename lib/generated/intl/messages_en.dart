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

  static String m0(type, date, maxTemp, minTemp, maxHumidity, minHumidity,
          minLight, maxLight, water) =>
      "Type: ${type}\nPlanting Date: ${date}\nMax Temp: ${maxTemp}°C\nMin Temp: ${minTemp}°C\nMax Humidity: ${maxHumidity}%\nMin Humidity: ${minHumidity}%\nLight: ${minLight}-${maxLight}h\nWater: ${water}ml/day";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "MainTitle": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
        "MaterialApp": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
        "PantallaCreacionPlantas": MessageLookupByLibrary.simpleMessage("1.0"),
        "PantallaInicio": MessageLookupByLibrary.simpleMessage("1.0"),
        "PantallaMain": MessageLookupByLibrary.simpleMessage("1.0"),
        "addPlantButton": MessageLookupByLibrary.simpleMessage("Add Plant"),
        "daysWithLife": MessageLookupByLibrary.simpleMessage("Days with life"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "drawer_header":
            MessageLookupByLibrary.simpleMessage("List of Options"),
        "graphs": MessageLookupByLibrary.simpleMessage("Graphs"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "humidityMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min humidity cannot be greater than max"),
        "lightMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min light hours cannot be greater than max"),
        "maxHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Max Humidity (%)"),
        "maxLightLabel":
            MessageLookupByLibrary.simpleMessage("Max Light Hours (h)"),
        "maxTempLabel":
            MessageLookupByLibrary.simpleMessage("Max Temperature (°C)"),
        "menu_create_plant":
            MessageLookupByLibrary.simpleMessage("Create Plant"),
        "menu_delete_plant":
            MessageLookupByLibrary.simpleMessage("Delete Plant"),
        "menu_modify_plant":
            MessageLookupByLibrary.simpleMessage("Modify Plant"),
        "menu_plant_tips": MessageLookupByLibrary.simpleMessage("Plant Tips"),
        "menu_sensor_check":
            MessageLookupByLibrary.simpleMessage("Sensor Check"),
        "milestones": MessageLookupByLibrary.simpleMessage("Milestones"),
        "minHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Min Humidity (%)"),
        "minLightLabel":
            MessageLookupByLibrary.simpleMessage("Min Light Hours (h)"),
        "minTempLabel":
            MessageLookupByLibrary.simpleMessage("Min Temperature (°C)"),
        "nameLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
        "plantDateLabel": MessageLookupByLibrary.simpleMessage("Planting Date"),
        "plantHealth":
            MessageLookupByLibrary.simpleMessage("Health Status: 75%"),
        "plantName": MessageLookupByLibrary.simpleMessage("Indoor Plant"),
        "plantStatus":
            MessageLookupByLibrary.simpleMessage("In good condition"),
        "plant_info": m0,
        "pleaseEnterName":
            MessageLookupByLibrary.simpleMessage("Please enter the plant name"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "tempMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min temperature cannot be greater than max"),
        "title": MessageLookupByLibrary.simpleMessage("Plant Creation"),
        "typeLabel": MessageLookupByLibrary.simpleMessage("Plant Type"),
        "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
        "waterLabel": MessageLookupByLibrary.simpleMessage("Daily Water (ml)"),
        "welcomeMessage": MessageLookupByLibrary.simpleMessage("TOMATO")
      };
}
