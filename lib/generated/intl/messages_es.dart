// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(min, max) => "Horas mínimas: ${min}, Horas máximas: ${max}";

  static String m1(type) => "Tipo de medida: ${type}";

  static String m2(model) => "Modelo: ${model}";

  static String m3(type, date, maxTemp, minTemp, maxHumidity, minHumidity,
          minLight, maxLight, water) =>
      "Tipo: ${type}\nFecha de Plantación: ${date}\nTemp Máx: ${maxTemp}°C\nTemp Mín: ${minTemp}°C\nHumedad Máx: ${maxHumidity}%\nHumedad Mín: ${minHumidity}%\nLuz: ${minLight}-${maxLight}h\nAgua: ${water}ml/día";

  static String m4(min, max) => "Rango: ${min} - ${max}";

  static String m5(reading, unit) => "Lectura: ${reading} ${unit}";

  static String m6(type) => "Tipo: ${type}";

  static String m7(unit) => "Unidad: ${unit}";

  static String m8(zone) => "Zona: ${zone}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "MainTitle": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
        "MaterialApp": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
        "PantallaMain": MessageLookupByLibrary.simpleMessage("1.0"),
        "addPlantButton": MessageLookupByLibrary.simpleMessage("Añadir Planta"),
        "appTitlesensors":
            MessageLookupByLibrary.simpleMessage("Sensores Activos"),
        "change_language": MessageLookupByLibrary.simpleMessage("Idioma"),
        "daysWithLife": MessageLookupByLibrary.simpleMessage("Días con vida"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "drawer_header": MessageLookupByLibrary.simpleMessage("Opciones"),
        "english": MessageLookupByLibrary.simpleMessage("Inglés"),
        "errorMessage": MessageLookupByLibrary.simpleMessage(
            "No se pudieron obtener los consejos"),
        "errorMessagesensors": MessageLookupByLibrary.simpleMessage(
            "No se pudieron obtener los sensores"),
        "graphs": MessageLookupByLibrary.simpleMessage("Gráficos"),
        "home": MessageLookupByLibrary.simpleMessage("Inicio"),
        "hoursLabel": m0,
        "humidityMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "La humedad mínima no puede ser mayor que la máxima"),
        "lightMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "La luz mínima no puede ser mayor que la máxima"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Cargando..."),
        "maxHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Humedad Máxima (%)"),
        "maxLightLabel":
            MessageLookupByLibrary.simpleMessage("Horas Máximas de Luz (h)"),
        "maxTempLabel":
            MessageLookupByLibrary.simpleMessage("Temperatura Máxima (°C)"),
        "measurementTypeLabel": m1,
        "menu_create_plant":
            MessageLookupByLibrary.simpleMessage("Crear Planta"),
        "menu_delete_plant":
            MessageLookupByLibrary.simpleMessage("Eliminar Planta"),
        "menu_modify_plant":
            MessageLookupByLibrary.simpleMessage("Modificar Planta"),
        "menu_sensor_check":
            MessageLookupByLibrary.simpleMessage("Comprobación Sensores"),
        "milestones": MessageLookupByLibrary.simpleMessage("Hitos"),
        "minHumidityLabel":
            MessageLookupByLibrary.simpleMessage("Humedad Mínima (%)"),
        "minLightLabel":
            MessageLookupByLibrary.simpleMessage("Horas Mínimas de Luz (h)"),
        "minTempLabel":
            MessageLookupByLibrary.simpleMessage("Temperatura Mínima (°C)"),
        "modelLabel": m2,
        "nameLabel":
            MessageLookupByLibrary.simpleMessage("Nombre de la Planta"),
        "plantDateLabel":
            MessageLookupByLibrary.simpleMessage("Fecha de Plantación"),
        "plantHealth":
            MessageLookupByLibrary.simpleMessage("Estado de Salud: 75%"),
        "plantName": MessageLookupByLibrary.simpleMessage("Planta de Interior"),
        "plantStatus": MessageLookupByLibrary.simpleMessage("En buen estado"),
        "plant_info": m3,
        "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
            "Por favor, ingresa el nombre de la planta"),
        "rangeLabel": m4,
        "readingLabel": m5,
        "screenTitlesensors":
            MessageLookupByLibrary.simpleMessage("Sensores Activos"),
        "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
        "spanish": MessageLookupByLibrary.simpleMessage("Español"),
        "tempMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
            "La temperatura mínima no puede ser mayor que la máxima"),
        "title": MessageLookupByLibrary.simpleMessage("Creación de Plantas"),
        "typeLabel": MessageLookupByLibrary.simpleMessage("Tipo de Planta"),
        "typeLabelsensors": m6,
        "unitLabel": m7,
        "viewDetails": MessageLookupByLibrary.simpleMessage("Ver Detalles"),
        "waterLabel": MessageLookupByLibrary.simpleMessage("Agua Diaria (ml)"),
        "welcomeMessage": MessageLookupByLibrary.simpleMessage("TOMATERA"),
        "zoneLabel": m8
      };
}
