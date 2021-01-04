# Code generation with Dart build system
This project should show how to work with some features of Dart build system that can reduce boilerplate code.<br/>
We will create builder in our package.

Featured packages:
1. build_runner;
2. build_version;
3. json_serializable, json_annotation;
4. checked_yaml;
5. build_cli;
6. build_verify

## Getting Started
[Base source: Kevin Moore](https://www.youtube.com/watch?v=iVoz7kJoLFQ)

## Initial pubspec.yaml and build_runner
```yaml
name: dart_build_live
description: Code generation with Dart build system
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 0.1.2-dev

environment:
  sdk: ">=2.7.0 <3.0.0"
dev_dependencies:
    build_runner: ^1.10.11 # does the work
```

```shell script 
pub run build_runner <command>
```
Where commands are ```build```, ```watch```, ```serve``` and ```test```. Check out [source](https://pub.dev/packages/build_runner).<br/>

If build_runner file not found: 
 1. Be sure that you are in correct folder (where pubspec.yaml is);
 2. Use following commands instead of the above

```shell script
flutter pub get
flutter packages get
flutter packages pub run build_runner build
```
[Source: github issue](https://github.com/dart-lang/build/issues/2581)

## Build version
Include version of your package in the source code. <br/>

* Add dev dependency:
```yaml
build_version: ^2.0.1 # has builder inside
```
* Make sure version is present:
```yaml
version: 0.1.2-dev
```

* Run to generate and update version:
```shell script
flutter packages pub run build_runner watch
```
Generates and later updates _src/version.dart_ from version in _pubspec.yaml_ file. 
Version is updated every time it is changed in _pubspec.yaml_, while _watch_ is on.


**Cancel watch.**

### JSON handling
* Add _src/customer.dart_

* Update _pubspec.yaml_
```yaml
dependencies:
    json_annotation: ^3.1.1
dev_dependencies:
    json_serializable: ^3.5.1 # defined in json_annotation package
```
Pay attention that json_annotation is package that contains json_serializable. And since we only need json_serializable we put it in dev_dependencies.

* Run to generate json mapper
```shell script
flutter packages pub run build_runner watch
```
* Json mapper class is generated at _src/customer.g.dart_ under _JsonSerializableGenerator_

All Json serializable fields are configured in pubspec.yaml. Some, but not all are by default true. If such is your desire you can change that. 
Check out keys for the options at
[more details on json_serializable](https://pub.dev/packages/json_serializable). There are two base ways to handle options.
1. Checkout _build.yaml_ for one example of changed option. Notice how _customer.g.dart_ changes based on that value (look at the map check :wink:). 
2. Checkout condition inside JsonSerializable. _last_ is not generated since it is not annotated.

At the moment(1. January 2020) it is not possible to change destination path automatically. 
Therefore unless you want source code to became dirty fast, you can move generated files manually, but pay attention to watch.  

# Under construction

## Other builders
built_runner contains among others
* built_value - provides Immutable value types, enums, JSON serialization
    [David Morgan](https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4)
    [pub](https://pub.dev/packages/built_value)
* pedantic - provides lint analysis

built_value contains among others
* build_collection - provides immutable collections
    [David Morgan](https://medium.com/dartlang/darts-built-collection-for-immutable-collections-db662f705eff)
    [pub](https://pub.dev/packages/built_collection)



## Checking YAML

Add following package
```yaml
dependencies:
  checked_yaml: ^1.0.4
```
It provides _checkedYamlDecode_ function which can provide helpful exception between yaml and target type. 
It is based on _json_serializable_ annotation of a class and its elements. <br/>


Lets create _main.dart_ class in _bin_ package

```dart
import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  nullable: true,
)
class Configuration {
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final int count;

  Configuration({this.name, this.count}) {
    if (name.isEmpty) {
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
   *
   * Reading from yaml file and printing the result
   *
   */
    var sourcePathOrYaml = arguments.single;
    String yamlContent;
  
    if (FileSystemEntity.isFileSync(sourcePathOrYaml)) {
        yamlContent = File(sourcePathOrYaml).readAsStringSync();
    } else {
        yamlContent = sourcePathOrYaml;
        sourcePathOrYaml = null;
    }
  
    final config = checkedYamlDecode(
        yamlContent, (m) => Configuration.fromJson(m),
        sourceUrl: sourcePathOrYaml);
  

  /** Reading from Yaml file */

  print(config);

}

```


Pay attention to the _main.dart_. and run following command 

```shell script
dart bin/main.dart pubspec.yaml
```
This command will run _main.dart_ with argument _pubspec.yaml_. It will read file and check keys of yaml 
against available keys in _Configuration_ based on requirements. For this parameter execution will throw exception since the keys from yaml do not exist.
but if we pass _sample.yaml_ 

```yaml
    name: kevin
    count: 42
```
it will pass the check and return nice JSON description.
Changing _42_ in _sample.yaml_ to _"42"_ will throw error upon execution of previous command, 
since the type is not correct upon check.


# Parsing command line arguments

Using Dart Built System, more specifically _build_cli_, we will parse command line arguments directly into  an annotation class.

Add following dependencies.
```yaml
dependencies:
  build_cli_annotations: ^1.2.0
dev_dependencies:
  build_cli: ^1.3.10   
```

On top of the _main.dart_ class we add ```dart @CliOptions()```. And run 
```shell script
flutter packages pub run build_runner watch
```

Now in _main.g.dart_ we can notice generated _CliGenerator_ code, 
notice that it is in the same file as generated _JsonSerializableGenerator_. <br/>

This new generated command line interface code provides us with the function, which will
for the list of arguments return _Configuration_ object. <br />

We can test this, ny replacing yaml part of code in the _main.dart_ with 

```dart
  final config = parseConfiguration(arguments);
```

And running

```shell script
  dart bin/main.dart --name kevin --count 42
```
If any of the arguments is missing the _build_cli_ will report error, 
as it is expecting all fields of the _Configuration_ to be non null and with appropriate type.

Further we can add now options
```dart
@CliOption(abbr: 'n', help: 'this is the name')
@CliOption(abbr: 'c', help: 'this is the count', defaultsTo: 0) // since it can be null, we have to provide default value for int
 
``` 
For each of the keys in Configuration. In addition we add new key _help_, 
since it is bool it is called _flag_ and not  _option_. <br />

Following we will add following lines in the main

```dart
   if (config.help == true) {
     print(_$parserForConfiguration.usage);
     return;
   }
```
It will call _usage_ related function that prints help messages. We can test this by calling

```shell script
  dart bin/main.dart --help
```

# Build dart web application

Package that does work in relation to building Flutter app. It builds it into another branch. 
Packages in configured in such a way that we can get both _yaml_ and _cli_ _Configuration_ object.

[Peanut](https://pub.dev/packages/peanut)


# Verify build
Tester for ensuring generated Dart code is working in case of version change.

First we add following dependency
```yaml
dev_dependencies:
  build_verify: ^1.1.1
```
And then create new class _test/ensure_build_test.dart_ and annotate it with

```dart
@Tags(['presubmit-only'])
```
from _test_ package. This _@Tags_ annotation will apply user defined tags. That tag is defined in _dart_test_ that is used by [Travis](#travis).


Following piece of code ensures that build does not change anything that it is hermetic.
```dart
void main(){
  test('ensure_build', expectBuildClean);
}
```



# <a href="travis">Travis</a>






