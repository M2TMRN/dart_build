import 'dart:io';

import 'package:build_cli_annotations/build_cli_annotations.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@CliOptions()
@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  nullable: false,
)
class Configuration {
  @CliOption(abbr: 'n', help: 'this is the name')
  @JsonKey(required: true)
  final String name;
  @CliOption(abbr: 'c', help: 'this is the count', defaultsTo: 0)
  @JsonKey(required: true)
  final int count;

  final bool help;

  Configuration({this.name, this.count, this.help}) {
    if (help != true && name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Cannot be empty');
    }
  }

  factory Configuration.fromJson(Map json) => _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @override
  String toString() => 'Configuration: ${toJson()}';
}

void main(List<String> arguments) {
  /**
   *  Reading from cli
   */

  final config = parseConfiguration(arguments);

  if (config.help == true) {
    print(_$parserForConfiguration.usage);
    return;
  }

  /** Reading from cli */

  /**
   *
   * Reading from yaml file and printing the result
   *
   */
  // var sourcePathOrYaml = arguments.single;
  // String yamlContent;
  //
  // if (FileSystemEntity.isFileSync(sourcePathOrYaml)) {
  //   yamlContent = File(sourcePathOrYaml).readAsStringSync();
  // } else {
  //   yamlContent = sourcePathOrYaml;
  //   sourcePathOrYaml = null;
  // }
  //
  // final config = checkedYamlDecode(
  //     yamlContent, (m) => Configuration.fromJson(m),
  //     sourceUrl: sourcePathOrYaml);
  //

  /** Reading from Yaml file */

  print(config);
}
