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

  static String m0(plantName) =>
      "¿Estás seguro de que quieres eliminar la planta \"${plantName}\"?";

  static String m1(count) => "${count} días";

  static String m2(percent) => "Estado de salud: ${percent}%";

  static String m3(min, max) => "Horas mínimas: ${min}, Horas máximas: ${max}";

  static String m4(type) => "Tipo de medida: ${type}";

  static String m5(model) => "Modelo: ${model}";

  static String m6(text) => "Consejo: ${text}";

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
      "Tipo: ${type}\nFecha de Plantación: ${date}\nTemp Máx: ${maxTemp}°C\nTemp Mín: ${minTemp}°C\nHumedad Máx: ${maxHumidity}%\nHumedad Mín: ${minHumidity}%\nLuz: ${minLight}-${maxLight}h\nAgua: ${water}ml/día";

  static String m8(min, max) => "Rango: ${min} - ${max}";

  static String m9(reading, unit) => "Lectura: ${reading} ${unit}";

  static String m10(type) => "Tipo: ${type}";

  static String m11(unit) => "Unidad: ${unit}";

  static String m12(zone) => "Zona: ${zone}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "MainTitle": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
    "MaterialApp": MessageLookupByLibrary.simpleMessage("GreenInHouse_2"),
    "PantallaMain": MessageLookupByLibrary.simpleMessage("1.0"),
    "accept": MessageLookupByLibrary.simpleMessage("Aceptar"),
    "activePlantsLabel": MessageLookupByLibrary.simpleMessage(
      "Plantas Activas",
    ),
    "activeSensors": MessageLookupByLibrary.simpleMessage("Sensores Activos"),
    "addPlantButton": MessageLookupByLibrary.simpleMessage("Añadir Planta"),
    "airHumidityHigh": MessageLookupByLibrary.simpleMessage(
      "Reduce la humedad, ventila el espacio.",
    ),
    "airHumidityLow": MessageLookupByLibrary.simpleMessage(
      "Aumenta la humedad del aire, pon un humidificador cerca.",
    ),
    "airHumidityOptimal": MessageLookupByLibrary.simpleMessage(
      "Humedad del ambiente en rango óptimo.",
    ),
    "ambienthumiditySensor": MessageLookupByLibrary.simpleMessage(
      "HUMEDAD AMBIENTE",
    ),
    "appTitleplants": MessageLookupByLibrary.simpleMessage(
      "Consejos de Plantas",
    ),
    "appTitlesensors": MessageLookupByLibrary.simpleMessage("Sensores Activos"),
    "areYouSureRemovePhoto": MessageLookupByLibrary.simpleMessage(
      "¿Estás seguro de que quieres quitar la foto?",
    ),
    "badState": MessageLookupByLibrary.simpleMessage("Mal estado de cuidado"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "change_language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "chartAmbientHumidity": MessageLookupByLibrary.simpleMessage(
      "Gráfica de Humedad Ambiente",
    ),
    "chartLight": MessageLookupByLibrary.simpleMessage("Gráfica de Luz"),
    "chartSoilMoisture": MessageLookupByLibrary.simpleMessage(
      "Gráfica de Humedad",
    ),
    "chartTemperature": MessageLookupByLibrary.simpleMessage(
      "Gráfica de Temperatura",
    ),
    "chooseFromGallery": MessageLookupByLibrary.simpleMessage(
      "Elegir de galería",
    ),
    "completeFieldsMessage": MessageLookupByLibrary.simpleMessage(
      "Por favor, completa todos los campos",
    ),
    "completed": MessageLookupByLibrary.simpleMessage("Completado"),
    "confirmDeleteMessage": m0,
    "confirmDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Confirmar eliminación",
    ),
    "confirmFertilizerQuestion": MessageLookupByLibrary.simpleMessage(
      "¿Has añadido fertilizante a la planta?",
    ),
    "confirmFertilizerTitle": MessageLookupByLibrary.simpleMessage(
      "Confirmar fertilizante",
    ),
    "confirmPhotoRemoval": MessageLookupByLibrary.simpleMessage(
      "Confirmar eliminación",
    ),
    "confirmSoilChangeQuestion": MessageLookupByLibrary.simpleMessage(
      "¿Has cambiado la tierra de la planta?",
    ),
    "confirmSoilChangeTitle": MessageLookupByLibrary.simpleMessage(
      "Confirmar cambio de tierra",
    ),
    "crearPlantaButton": MessageLookupByLibrary.simpleMessage("Crear Planta"),
    "createNewTipoPlanta": MessageLookupByLibrary.simpleMessage(
      "Crear un nuevo tipo de planta",
    ),
    "dailyMilestones": MessageLookupByLibrary.simpleMessage("Hitos Diarios"),
    "dateTimeAxis": MessageLookupByLibrary.simpleMessage("Fecha y Hora"),
    "daysBack": MessageLookupByLibrary.simpleMessage("Días atrás:"),
    "daysCount": m1,
    "daysWithLife": MessageLookupByLibrary.simpleMessage("Días con vida"),
    "degrees": MessageLookupByLibrary.simpleMessage("Temperatura (ºC)"),
    "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "deletePlantButton": MessageLookupByLibrary.simpleMessage(
      "Eliminar Planta",
    ),
    "deletePlantTitle": MessageLookupByLibrary.simpleMessage("Eliminar Planta"),
    "descripcionPlantaLabel": MessageLookupByLibrary.simpleMessage(
      "Descripción del Tipo de Planta",
    ),
    "drawer_header": MessageLookupByLibrary.simpleMessage("Opciones"),
    "english": MessageLookupByLibrary.simpleMessage("Inglés"),
    "errorConnectingToServer": MessageLookupByLibrary.simpleMessage(
      "Error al conectar con el servidor.",
    ),
    "errorCreatingPlant": MessageLookupByLibrary.simpleMessage(
      "Error al crear la planta",
    ),
    "errorFetchingData": MessageLookupByLibrary.simpleMessage(
      "No recoge datos",
    ),
    "errorMessage": MessageLookupByLibrary.simpleMessage(
      "No se pudieron obtener los consejos",
    ),
    "errorMessagesensors": MessageLookupByLibrary.simpleMessage(
      "No se pudieron obtener los sensores",
    ),
    "fertilizerFrequency": MessageLookupByLibrary.simpleMessage(
      "⏳ Frecuencia del fertilizante (días)",
    ),
    "fertilizerInLessThanMonth": MessageLookupByLibrary.simpleMessage(
      "Queda menos de un mes para volver a añadir fertilizante",
    ),
    "fertilizerOverdue": MessageLookupByLibrary.simpleMessage(
      "Añade fertilizante, ya ha pasado el plazo definido",
    ),
    "fertilizerRecentlyAdded": MessageLookupByLibrary.simpleMessage(
      "Fertilizante añadido recientemente.",
    ),
    "goodState": MessageLookupByLibrary.simpleMessage("Buen estado de cuidado"),
    "graphs": MessageLookupByLibrary.simpleMessage("Gráficos"),
    "guardarTipoPlantaButton": MessageLookupByLibrary.simpleMessage(
      "Guardar Tipo de Planta",
    ),
    "healthStatus": m2,
    "home": MessageLookupByLibrary.simpleMessage("Inicio"),
    "hoursLabel": m3,
    "humidityMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
      "La humedad mínima no puede ser mayor que la máxima",
    ),
    "humiditySensor": MessageLookupByLibrary.simpleMessage("HUMEDAD"),
    "lastReading": MessageLookupByLibrary.simpleMessage("Última lectura"),
    "lightHigh": MessageLookupByLibrary.simpleMessage(
      "La planta recibe demasiada luz, ponla en sombra.",
    ),
    "lightLow": MessageLookupByLibrary.simpleMessage(
      "La planta necesita más luz, colócala en un lugar más iluminado.",
    ),
    "lightMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
      "La luz mínima no puede ser mayor que la máxima",
    ),
    "lightOptimal": MessageLookupByLibrary.simpleMessage(
      "Luminosidad en rango óptimo.",
    ),
    "loadingMessage": MessageLookupByLibrary.simpleMessage("Cargando..."),
    "loadingState": MessageLookupByLibrary.simpleMessage("Cargando estado..."),
    "luminositySensor": MessageLookupByLibrary.simpleMessage("LUMINOSIDAD"),
    "lux": MessageLookupByLibrary.simpleMessage("Lux"),
    "maxHumidityLabel": MessageLookupByLibrary.simpleMessage(
      "Humedad Máxima (%)",
    ),
    "maxLightLabel": MessageLookupByLibrary.simpleMessage(
      "Horas Máximas de Luz (h)",
    ),
    "maxTempLabel": MessageLookupByLibrary.simpleMessage(
      "Temperatura Máxima (°C)",
    ),
    "measurementTypeLabel": m4,
    "menu_create_plant": MessageLookupByLibrary.simpleMessage("Crear Planta"),
    "menu_delete_plant": MessageLookupByLibrary.simpleMessage(
      "Eliminar Planta",
    ),
    "menu_modify_plant": MessageLookupByLibrary.simpleMessage(
      "Modificar Planta",
    ),
    "menu_sensor_check": MessageLookupByLibrary.simpleMessage(
      "Comprobación Sensores",
    ),
    "milestoneAmbientHumidity": MessageLookupByLibrary.simpleMessage(
      "Humedad Ambiente",
    ),
    "milestoneFertilizer": MessageLookupByLibrary.simpleMessage("Fertilizante"),
    "milestoneLight": MessageLookupByLibrary.simpleMessage("Luz"),
    "milestoneSoilChange": MessageLookupByLibrary.simpleMessage(
      "Cambio de Tierra",
    ),
    "milestoneSoilMoisture": MessageLookupByLibrary.simpleMessage(
      "Humedad del Suelo",
    ),
    "milestoneTemperature": MessageLookupByLibrary.simpleMessage("Temperatura"),
    "milestones": MessageLookupByLibrary.simpleMessage("Hitos"),
    "milestonesProgress": MessageLookupByLibrary.simpleMessage(
      "Progreso de Hitos",
    ),
    "milestonesTitle": MessageLookupByLibrary.simpleMessage("Hitos"),
    "minHumidityLabel": MessageLookupByLibrary.simpleMessage(
      "Humedad Mínima (%)",
    ),
    "minLightLabel": MessageLookupByLibrary.simpleMessage(
      "Horas Mínimas de Luz (h)",
    ),
    "minTempLabel": MessageLookupByLibrary.simpleMessage(
      "Temperatura Mínima (°C)",
    ),
    "model": MessageLookupByLibrary.simpleMessage("Modelo"),
    "modelLabel": m5,
    "modifyPlantButton": MessageLookupByLibrary.simpleMessage(
      "Modificar Planta",
    ),
    "modifyPlantTitle": MessageLookupByLibrary.simpleMessage(
      "Modificar Planta",
    ),
    "monthlyMilestones": MessageLookupByLibrary.simpleMessage(
      "Hitos Mensuales",
    ),
    "nameLabel": MessageLookupByLibrary.simpleMessage("Nombre de la Planta"),
    "newPlantFertilizerMessage": MessageLookupByLibrary.simpleMessage(
      "Creación de nueva planta, se requiere de fertilizante",
    ),
    "newPlantSoilMessage": MessageLookupByLibrary.simpleMessage(
      "Planta recién creada, marca si el cambio de tierra está hecho.",
    ),
    "newPlantTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Nuevo Tipo de Planta",
    ),
    "nextApplication": MessageLookupByLibrary.simpleMessage(
      "Próxima aplicación",
    ),
    "nextChange": MessageLookupByLibrary.simpleMessage("Próximo cambio"),
    "noActivePlantMessage": MessageLookupByLibrary.simpleMessage(
      "No se ha detectado ninguna planta activa.\n\nPor favor, crea una planta antes de continuar.",
    ),
    "noActivePlantTitle": MessageLookupByLibrary.simpleMessage(
      "Sin planta activa",
    ),
    "noConnectionAccept": MessageLookupByLibrary.simpleMessage("Aceptar"),
    "noConnectionMessage": MessageLookupByLibrary.simpleMessage(
      "No se pudo conectar con el servidor.\nPor favor, revisa tu conexión de red y que la maceta esté funcionando y conectada a la red wifi.",
    ),
    "noConnectionTitle": MessageLookupByLibrary.simpleMessage("Sin conexión"),
    "noData": MessageLookupByLibrary.simpleMessage("No hay datos disponibles"),
    "noReading": MessageLookupByLibrary.simpleMessage("Sin lectura"),
    "noUnit": MessageLookupByLibrary.simpleMessage("Sin unidad"),
    "nombrePlantaLabel": MessageLookupByLibrary.simpleMessage(
      "Nombre de la Planta",
    ),
    "nombreTipoPlantaLabel": MessageLookupByLibrary.simpleMessage(
      "Nombre del Tipo de Planta",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pendiente"),
    "percentageAxis": MessageLookupByLibrary.simpleMessage("Porcentaje (%)"),
    "photoNeedsPlant": MessageLookupByLibrary.simpleMessage(
      "Debes crear una planta antes de añadir una foto",
    ),
    "plantCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "¡Planta creada con éxito!",
    ),
    "plantDateLabel": MessageLookupByLibrary.simpleMessage(
      "Fecha de Plantación",
    ),
    "plantDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Planta eliminada correctamente",
    ),
    "plantHealth": MessageLookupByLibrary.simpleMessage("Estado de Salud: 75%"),
    "plantName": MessageLookupByLibrary.simpleMessage("Planta de Interior"),
    "plantNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nombre de la Planta",
    ),
    "plantStatus": MessageLookupByLibrary.simpleMessage("En buen estado"),
    "plantTipDescription": m6,
    "plantTypeModifiedMessage": MessageLookupByLibrary.simpleMessage(
      "Tipo de planta modificado correctamente",
    ),
    "plant_info": m7,
    "plantaCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Planta creada correctamente",
    ),
    "pleaseEnterAllFields": MessageLookupByLibrary.simpleMessage(
      "Por favor, rellene todos los campos.",
    ),
    "pleaseEnterName": MessageLookupByLibrary.simpleMessage(
      "Por favor, ingresa el nombre de la planta",
    ),
    "rangeLabel": m8,
    "readingLabel": m9,
    "recentSoilChange": MessageLookupByLibrary.simpleMessage(
      "Cambio de tierra reciente, todo en orden.",
    ),
    "regularState": MessageLookupByLibrary.simpleMessage(
      "Regular estado de cuidado",
    ),
    "removePhoto": MessageLookupByLibrary.simpleMessage("Quitar foto"),
    "screenTitlePlantTips": MessageLookupByLibrary.simpleMessage(
      "Consejos para tus plantas",
    ),
    "screenTitleplants": MessageLookupByLibrary.simpleMessage(
      "Consejos de Plantas",
    ),
    "screenTitlesensors": MessageLookupByLibrary.simpleMessage(
      "Sensores Activos",
    ),
    "selectActivePlantToDelete": MessageLookupByLibrary.simpleMessage(
      "Selecciona una planta activa para eliminar:",
    ),
    "selectDays": MessageLookupByLibrary.simpleMessage("Selecciona los días"),
    "selectPlantAndTypeMessage": MessageLookupByLibrary.simpleMessage(
      "Por favor, selecciona una planta y un nuevo tipo",
    ),
    "selectPlantToDelete": MessageLookupByLibrary.simpleMessage(
      "Por favor, selecciona una planta para eliminar",
    ),
    "selectPlantToModify": MessageLookupByLibrary.simpleMessage(
      "Selecciona una planta activa para modificar:",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "showCharts": MessageLookupByLibrary.simpleMessage("📊 Mostrar gráficas"),
    "showMilestones": MessageLookupByLibrary.simpleMessage("✨ Mostrar Hitos"),
    "soilChangeFrequency": MessageLookupByLibrary.simpleMessage(
      "⏳ Frecuencia del cambio de tierra (días)",
    ),
    "soilChangeInLessThanMonth": MessageLookupByLibrary.simpleMessage(
      "Queda menos de un mes para el cambio de tierra",
    ),
    "soilChangeOverdue": MessageLookupByLibrary.simpleMessage(
      "Cambia la tierra de la planta, ya ha pasado el tiempo definido.",
    ),
    "soilMoistureHigh": MessageLookupByLibrary.simpleMessage(
      "No riegues más, el suelo está demasiado húmedo.",
    ),
    "soilMoistureLow": MessageLookupByLibrary.simpleMessage(
      "Riega la planta, necesita más agua.",
    ),
    "soilMoistureOptimal": MessageLookupByLibrary.simpleMessage(
      "Humedad del suelo en rango óptimo.",
    ),
    "soonToAdd": MessageLookupByLibrary.simpleMessage("Pronto a añadir"),
    "soonToChange": MessageLookupByLibrary.simpleMessage("Pronto a cambiar"),
    "spanish": MessageLookupByLibrary.simpleMessage("Español"),
    "step1Title": MessageLookupByLibrary.simpleMessage(
      "Paso 1: Seleccionar o Crear Tipo de Planta",
    ),
    "step2Title": MessageLookupByLibrary.simpleMessage("Paso 2: Crear Planta"),
    "takePhoto": MessageLookupByLibrary.simpleMessage("Tomar foto"),
    "tapToAddPhoto": MessageLookupByLibrary.simpleMessage(
      "Pulsa para añadir foto",
    ),
    "tempMinGreaterThanMax": MessageLookupByLibrary.simpleMessage(
      "La temperatura mínima no puede ser mayor que la máxima",
    ),
    "temperatureHigh": MessageLookupByLibrary.simpleMessage(
      "Hace demasiado calor, aleja la planta del sol.",
    ),
    "temperatureLow": MessageLookupByLibrary.simpleMessage(
      "Hace demasiado frío, acerca la planta a un lugar más cálido.",
    ),
    "temperatureOptimal": MessageLookupByLibrary.simpleMessage(
      "Temperatura en rango óptimo.",
    ),
    "temperatureSensor": MessageLookupByLibrary.simpleMessage("TEMPERATURA"),
    "tipoPlantaCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Tipo de planta creado correctamente",
    ),
    "tipoPlantaLabel": MessageLookupByLibrary.simpleMessage("Tipo de Planta"),
    "title": MessageLookupByLibrary.simpleMessage("Creación de Plantas"),
    "type": MessageLookupByLibrary.simpleMessage("Tipo"),
    "typeLabel": MessageLookupByLibrary.simpleMessage("Tipo de Planta"),
    "typeLabelsensors": m10,
    "understood": MessageLookupByLibrary.simpleMessage("Entendido"),
    "unitLabel": m11,
    "unknownModel": MessageLookupByLibrary.simpleMessage("Modelo desconocido"),
    "unknownName": MessageLookupByLibrary.simpleMessage("Nombre desconocido"),
    "unknownState": MessageLookupByLibrary.simpleMessage("Desconocido"),
    "unknownType": MessageLookupByLibrary.simpleMessage("Tipo desconocido"),
    "unknownZone": MessageLookupByLibrary.simpleMessage("Zona no especificada"),
    "updateGraph": MessageLookupByLibrary.simpleMessage("Actualizar Gráfica"),
    "veryBadState": MessageLookupByLibrary.simpleMessage(
      "Muy mal estado de cuidado",
    ),
    "veryGoodState": MessageLookupByLibrary.simpleMessage(
      "Muy buen estado de cuidado",
    ),
    "viewDetails": MessageLookupByLibrary.simpleMessage("Ver Detalles"),
    "viewPlantTips": MessageLookupByLibrary.simpleMessage(
      "Ver Consejos de Plantas",
    ),
    "waterLabel": MessageLookupByLibrary.simpleMessage("Agua Diaria (ml)"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage("TOMATERA"),
    "withOutData": MessageLookupByLibrary.simpleMessage("Sin datos"),
    "yesAdded": MessageLookupByLibrary.simpleMessage("Sí, lo he hecho"),
    "yesChanged": MessageLookupByLibrary.simpleMessage("Sí, la cambié"),
    "yesRemove": MessageLookupByLibrary.simpleMessage("Sí, eliminar"),
    "zone": MessageLookupByLibrary.simpleMessage("Zona"),
    "zoneLabel": m12,
  };
}
