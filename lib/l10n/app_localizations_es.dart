// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get materialApp => 'GreenInHouse_2';

  @override
  String get pantallaMain => '1.0';

  @override
  String get mainTitle => 'GreenInHouse_2';

  @override
  String get graphs => 'Gráficos';

  @override
  String get milestones => 'Hitos';

  @override
  String get home => 'Inicio';

  @override
  String get settings => 'Ajustes';

  @override
  String get screenTitlePlantTips => 'Consejos para tus plantas';

  @override
  String plantTipDescription(Object text) {
    return 'Consejo: $text';
  }

  @override
  String zoneLabel(Object zone) {
    return 'Zona: $zone';
  }

  @override
  String measurementTypeLabel(Object type) {
    return 'Tipo de medida: $type';
  }

  @override
  String rangeLabel(Object max, Object min) {
    return 'Rango: $min - $max';
  }

  @override
  String hoursLabel(Object max, Object min) {
    return 'Horas mínimas: $min, Horas máximas: $max';
  }

  @override
  String get noConnectionTitle => 'Sin conexión';

  @override
  String get noConnectionMessage => 'No se pudo conectar con el servidor.\nPor favor, revisa tu conexión de red y que la maceta esté funcionando y conectada a la red wifi.';

  @override
  String get noConnectionAccept => 'Aceptar';

  @override
  String get selectDays => 'Selecciona los días';

  @override
  String get selectDate => 'Seleccionar fechas';

  @override
  String get accept => 'Aceptar';

  @override
  String get daysBack => 'Días atrás:';

  @override
  String get updateGraph => 'Actualizar Gráfico';

  @override
  String get noData => 'No hay datos disponibles';

  @override
  String get dateTimeAxis => 'Fecha y Hora';

  @override
  String get percentageAxis => 'Porcentaje (%)';

  @override
  String daysCount(Object count) {
    return '$count días';
  }

  @override
  String get lux => 'Lux';

  @override
  String get degrees => 'Temperatura (ºC)';

  @override
  String get humiditySensor => 'HUMEDAD';

  @override
  String get ambienthumiditySensor => 'HUMEDAD AMBIENTE';

  @override
  String get luminositySensor => 'LUMINOSIDAD';

  @override
  String get temperatureSensor => 'TEMPERATURA';

  @override
  String get loadingMessage => 'Cargando...';

  @override
  String get completed => 'Completado';

  @override
  String get pending => 'Pendiente';

  @override
  String get cancel => 'Cancelar';

  @override
  String get soilMoistureLow => 'Riega la planta, necesita más agua.';

  @override
  String get soilMoistureHigh => 'No riegues más, el suelo está demasiado húmedo.';

  @override
  String get soilMoistureOptimal => 'Humedad del suelo en rango óptimo.';

  @override
  String get airHumidityLow => 'Aumenta la humedad del aire, pon un humidificador cerca.';

  @override
  String get airHumidityHigh => 'Reduce la humedad, ventila el espacio.';

  @override
  String get airHumidityOptimal => 'Humedad del ambiente en rango óptimo.';

  @override
  String get lightLow => 'La planta necesita más luz, colócala en un lugar más iluminado.';

  @override
  String get lightHigh => 'La planta recibe demasiada luz, ponla en sombra.';

  @override
  String get lightOptimal => 'Luminosidad en rango óptimo.';

  @override
  String get temperatureLow => 'Hace demasiado frío, acerca la planta a un lugar más cálido.';

  @override
  String get temperatureHigh => 'Hace demasiado calor, aleja la planta del sol.';

  @override
  String get temperatureOptimal => 'Temperatura en rango óptimo.';

  @override
  String get milestonesTitle => 'Hitos';

  @override
  String get milestonesProgress => 'Progreso de Hitos';

  @override
  String get dailyMilestones => 'Hitos Diarios';

  @override
  String get monthlyMilestones => 'Hitos Mensuales';

  @override
  String get soonToChange => 'Pronto a cambiar';

  @override
  String get soonToAdd => 'Pronto a añadir';

  @override
  String get recentSoilChange => 'Cambio de tierra reciente, todo en orden.';

  @override
  String get soilChangeInLessThanMonth => 'Queda menos de un mes para el cambio de tierra';

  @override
  String get soilChangeOverdue => 'Cambia la tierra de la planta, ya ha pasado el tiempo definido.';

  @override
  String get nextChange => 'Próximo cambio';

  @override
  String get confirmSoilChangeTitle => 'Confirmar cambio de tierra';

  @override
  String get confirmSoilChangeQuestion => '¿Has cambiado la tierra de la planta?';

  @override
  String get yesChanged => 'Sí, la cambié';

  @override
  String get fertilizerRecentlyAdded => 'Fertilizante añadido recientemente.';

  @override
  String get fertilizerInLessThanMonth => 'Queda menos de un mes para volver a añadir fertilizante';

  @override
  String get fertilizerOverdue => 'Añade fertilizante, ya ha pasado el plazo definido';

  @override
  String get nextApplication => 'Próxima aplicación';

  @override
  String get confirmFertilizerTitle => 'Confirmar fertilizante';

  @override
  String get confirmFertilizerQuestion => '¿Has añadido fertilizante a la planta?';

  @override
  String get yesAdded => 'Sí, lo he hecho';

  @override
  String get newPlantFertilizerMessage => 'Creación de nueva planta, se requiere de fertilizante';

  @override
  String get newPlantSoilMessage => 'Planta recién creada, marca si el cambio de tierra está hecho.';

  @override
  String get photoNeedsPlant => 'Debes crear una planta antes de añadir una foto';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get chooseFromGallery => 'Elegir de galería';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get confirmPhotoRemoval => 'Confirmar eliminación';

  @override
  String get areYouSureRemovePhoto => '¿Estás seguro de que quieres quitar la foto?';

  @override
  String get yesRemove => 'Sí, eliminar';

  @override
  String get tapToAddPhoto => 'Pulsa para añadir foto';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get showGraphs => '📊 Mostrar gráficos';

  @override
  String get graphSoilMoisture => 'Gráfico de Humedad';

  @override
  String get graphAmbientHumidity => 'Gráfico de Humedad Ambiente';

  @override
  String get graphLight => 'Gráfico de Luz';

  @override
  String get graphTemperature => 'Gráfico de Temperatura';

  @override
  String get showMilestones => '✨ Mostrar Hitos';

  @override
  String get milestoneSoilMoisture => 'Humedad del Suelo';

  @override
  String get milestoneAmbientHumidity => 'Humedad Ambiente';

  @override
  String get milestoneLight => 'Luz';

  @override
  String get milestoneTemperature => 'Temperatura';

  @override
  String get milestoneSoilChange => 'Cambio de Tierra';

  @override
  String get milestoneFertilizer => 'Fertilizante';

  @override
  String get soilChangeFrequency => '⏳ Frecuencia del cambio de tierra (días)';

  @override
  String get fertilizerFrequency => '⏳ Frecuencia del fertilizante (días)';

  @override
  String get change_language => 'Idioma';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';

  @override
  String get activeSensors => 'Sensores Activos';

  @override
  String get errorFetchingData => 'No recoge datos';

  @override
  String get withOutData => 'Sin datos';

  @override
  String get unknownName => 'Nombre desconocido';

  @override
  String get unknownModel => 'Modelo desconocido';

  @override
  String get unknownType => 'Tipo desconocido';

  @override
  String get unknownZone => 'Zona no especificada';

  @override
  String get noReading => 'Sin lectura';

  @override
  String get noUnit => 'Sin unidad';

  @override
  String get model => 'Modelo';

  @override
  String get type => 'Tipo';

  @override
  String get zone => 'Zona';

  @override
  String get lastReading => 'Última lectura';

  @override
  String get completeFieldsMessage => 'Por favor, completa todos los campos';

  @override
  String get tipoPlantaCreatedMessage => 'Tipo de planta creado correctamente';

  @override
  String get step1Title => 'Paso 1: Seleccionar o Crear Tipo de Planta';

  @override
  String get tipoPlantaLabel => 'Tipo de Planta';

  @override
  String get createNewTipoPlanta => 'Crear un nuevo tipo de planta';

  @override
  String get nombreTipoPlantaLabel => 'Nombre del Tipo de Planta';

  @override
  String get descripcionPlantaLabel => 'Descripción del Tipo de Planta';

  @override
  String get guardarTipoPlantaButton => 'Guardar Tipo de Planta';

  @override
  String get step2Title => 'Paso 2: Crear Planta';

  @override
  String get nombrePlantaLabel => 'Nombre de la Planta';

  @override
  String get crearPlantaButton => 'Crear Planta';

  @override
  String get deletePlantTitle => 'Eliminar Planta';

  @override
  String get selectActivePlantToDelete => 'Selecciona una planta activa para eliminar:';

  @override
  String get activePlantsLabel => 'Plantas Activas';

  @override
  String get deletePlantButton => 'Eliminar Planta';

  @override
  String get selectPlantToDelete => 'Por favor, selecciona una planta para eliminar';

  @override
  String get confirmDeleteTitle => 'Confirmar eliminación';

  @override
  String confirmDeleteMessage(Object plantName) {
    return '¿Estás seguro de que quieres eliminar la planta \"$plantName\"?';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get plantDeletedMessage => 'Planta eliminada correctamente';

  @override
  String get noActivePlantTitle => 'Sin planta activa';

  @override
  String get noActivePlantMessage => 'No se ha detectado ninguna planta activa.\n\nPor favor, crea una planta antes de continuar.';

  @override
  String get understood => 'Entendido';

  @override
  String get daysWithLife => 'Días con vida';

  @override
  String get plantName => 'Planta de Interior';

  @override
  String get viewPlantTips => 'Ver Consejos de Plantas';

  @override
  String get drawer_header => 'Opciones';

  @override
  String get menu_create_plant => 'Crear Planta';

  @override
  String get title => 'Creación de Plantas';

  @override
  String get menu_modify_plant => 'Modificar Planta';

  @override
  String get menu_delete_plant => 'Eliminar Planta';

  @override
  String get menu_change_plant => 'Cambio de Planta';

  @override
  String get menu_sensor_check => 'Comprobación Sensores';

  @override
  String get modifyPlantTitle => 'Modificar Planta';

  @override
  String get selectPlantToModify => 'Selecciona una planta activa para modificar:';

  @override
  String get plantNameLabel => 'Nombre de la Planta';

  @override
  String get newPlantTypeLabel => 'Nuevo Tipo de Planta';

  @override
  String get modifyPlantButton => 'Modificar Planta';

  @override
  String get selectPlantAndTypeMessage => 'Por favor, selecciona una planta y un nuevo tipo';

  @override
  String get plantTypeModifiedMessage => 'Tipo de planta modificado correctamente';

  @override
  String get loadingState => 'Cargando estado...';

  @override
  String get veryBadState => 'Muy mal estado de cuidado';

  @override
  String get badState => 'Mal estado de cuidado';

  @override
  String get regularState => 'Regular estado de cuidado';

  @override
  String get goodState => 'Buen estado de cuidado';

  @override
  String get veryGoodState => 'Muy buen estado de cuidado';

  @override
  String get unknownState => 'Desconocido';

  @override
  String healthStatus(Object percent) {
    return 'Estado de cuidado: $percent%';
  }

  @override
  String get nameLabel => 'Nombre de la Planta';

  @override
  String get typeLabel => 'Tipo de Planta';

  @override
  String get plantDateLabel => 'Fecha de Plantación';

  @override
  String get maxTempLabel => 'Temperatura Máxima (°C)';

  @override
  String get minTempLabel => 'Temperatura Mínima (°C)';

  @override
  String get maxHumidityLabel => 'Humedad Máxima (%)';

  @override
  String get minHumidityLabel => 'Humedad Mínima (%)';

  @override
  String get maxLightLabel => 'Horas Máximas de Luz (h)';

  @override
  String get minLightLabel => 'Horas Mínimas de Luz (h)';

  @override
  String get waterLabel => 'Agua Diaria (ml)';

  @override
  String get addPlantButton => 'Añadir Planta';

  @override
  String get pleaseEnterName => 'Por favor, ingresa el nombre de la planta';

  @override
  String get tempMinGreaterThanMax => 'La temperatura mínima no puede ser mayor que la máxima';

  @override
  String get humidityMinGreaterThanMax => 'La humedad mínima no puede ser mayor que la máxima';

  @override
  String get lightMinGreaterThanMax => 'La luz mínima no puede ser mayor que la máxima';

  @override
  String plant_info(Object date, Object maxHumidity, Object maxLight, Object maxTemp, Object minHumidity, Object minLight, Object minTemp, Object type, Object water) {
    return 'Tipo: $type\nFecha de Plantación: $date\nTemp Máx: $maxTemp°C\nTemp Mín: $minTemp°C\nHumedad Máx: $maxHumidity%\nHumedad Mín: $minHumidity%\nLuz: $minLight-${maxLight}h\nAgua: ${water}ml/día';
  }

  @override
  String get plantaCreatedMessage => 'Planta creada correctamente';

  @override
  String get welcomeMessage => 'TOMATERA';

  @override
  String get plantStatus => 'En buen estado';

  @override
  String get plantHealth => 'Estado de Salud: 75%';

  @override
  String get viewDetails => 'Ver Detalles';

  @override
  String get appTitleplants => 'Consejos de Plantas';

  @override
  String get screenTitleplants => 'Consejos de Plantas';

  @override
  String get errorMessage => 'No se pudieron obtener los consejos';

  @override
  String unitLabel(Object unit) {
    return 'Unidad: $unit';
  }

  @override
  String get appTitlesensors => 'Sensores Activos';

  @override
  String get screenTitlesensors => 'Sensores Activos';

  @override
  String get errorMessagesensors => 'No se pudieron obtener los sensores';

  @override
  String modelLabel(Object model) {
    return 'Modelo: $model';
  }

  @override
  String typeLabelsensors(Object type) {
    return 'Tipo: $type';
  }

  @override
  String readingLabel(Object reading, Object unit) {
    return 'Lectura: $reading $unit';
  }

  @override
  String get pleaseEnterAllFields => 'Por favor, rellene todos los campos.';

  @override
  String get plantCreatedSuccess => '¡Planta creada con éxito!';

  @override
  String get errorCreatingPlant => 'Error al crear la planta';

  @override
  String get errorConnectingToServer => 'Error al conectar con el servidor.';
}
