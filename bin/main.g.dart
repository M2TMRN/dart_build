// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

T _$badNumberFormat<T extends num>(
        String source, String type, String argName) =>
    throw FormatException(
        'Cannot parse "$source" into `$type` for option "$argName".');

Configuration _$parseConfigurationResult(ArgResults result) => Configuration(
    name: result['name'] as String,
    count: int.tryParse(result['count'] as String) ??
        _$badNumberFormat(result['count'] as String, 'int', 'count'),
    help: result['help'] as bool);

ArgParser _$populateConfigurationParser(ArgParser parser) => parser
  ..addOption('name', abbr: 'n', help: 'this is the name')
  ..addOption('count', abbr: 'c', help: 'this is the count', defaultsTo: '0')
  ..addFlag('help');

final _$parserForConfiguration = _$populateConfigurationParser(ArgParser());

Configuration parseConfiguration(List<String> args) {
  final result = _$parserForConfiguration.parse(args);
  return _$parseConfigurationResult(result);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map json) {
  return $checkedNew('Configuration', json, () {
    $checkKeys(json,
        allowedKeys: const ['name', 'count', 'help'],
        requiredKeys: const ['name', 'count']);
    final val = Configuration(
      name: $checkedConvert(json, 'name', (v) => v as String),
      count: $checkedConvert(json, 'count', (v) => v as int),
      help: $checkedConvert(json, 'help', (v) => v as bool),
    );
    return val;
  });
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'help': instance.help,
    };
