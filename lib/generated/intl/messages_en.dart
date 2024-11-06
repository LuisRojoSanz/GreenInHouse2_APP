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
        "PantallaMain": MessageLookupByLibrary.simpleMessage("1.0"),
        "addPlantButton": MessageLookupByLibrary.simpleMessage("Add Plant"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
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
        "minHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Min Humidity (%)"),
        "minLightLabel":
            MessageLookupByLibrary.simpleMessage("Min Light Hours (h)"),
        "minTempLabel":
            MessageLookupByLibrary.simpleMessage("Min Temperature (°C)"),
        "nameLabel": MessageLookupByLibrary.simpleMessage("Plant Name"),
        "plantDateLabel": MessageLookupByLibrary.simpleMessage("Planting Date"),
        "plant_info": m0,
        "pleaseEnterName":
            MessageLookupByLibrary.simpleMessage("Please enter the plant name"),
        "tempMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "Min temperature cannot be greater than max"),
        "title": MessageLookupByLibrary.simpleMessage("Plant Creation"),
        "typeLabel": MessageLookupByLibrary.simpleMessage("Plant Type"),
        "waterLabel": MessageLookupByLibrary.simpleMessage("Daily Water (ml)")
      };
}
