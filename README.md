# Code generation with Dart build system
This project should show how to work with some features of Dart build system that can reduce boilerplate code.<br/>
Featured packages:
1. build_runner;
2. build_version;
3. json_serializable.

## Getting Started
[Base source: Kevin Moore](https://www.youtube.com/watch?v=iVoz7kJoLFQ)

## Initial pubspec.yaml and build_runner
```
name: dart_build_live
description: Code generation with Dart build system
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

version: 0.1.2-dev

environment:
  sdk: ">=2.7.0 <3.0.0"
dev_dependencies:
    build_runner: ^1.10.11 # does the work
    pedantic: ^1.8.0 # lint analysis
```

``` shell script  
pub run build_runner <command>
```
Where commands are ```build```, ```watch```, ```serve``` and ```test```. Check out [source](https://pub.dev/packages/build_runner).<br/>

If build_runner file not found: 
 1. Be sure that you are in correct folder (where pubspec.yaml is);
 2. Use following commands instead of the above

``` shell script
flutter pub get
flutter packages get
flutter packages pub run build_runner build
```
[Source: github issue](https://github.com/dart-lang/build/issues/2581)

## Build version
Include version of your package in source code. <br/>

* Add dev dependency:
```
build_version: ^2.0.1 # has builder inside
```
* Make sure version is present:
```
version: 0.1.2-dev
```

* Run to generate and update version:
``` shell script
flutter packages pub run build_runner watch
```
Generates and later updates _src/version.dart_ from version in _pubspec.yaml_ file. Version is updated every time it is changed in _pubspec.yaml_, while _watch_ is on.


**Cancel watch.**

### JSON handling
* Add _src/customer.dart_

* Update _pubspec.yaml_
```
dependencies:
    json_annotation: ^3.1.1
dev_dependencies:
    json_serializable: ^3.5.1
```

* Run to generate json mapper
``` shell script
flutter packages pub run build_runner watch
```
* Json mapper class is generated at _src/customer.g.dart_

All Json serializable fields are configured in pubspec.yaml. Some, but not all are by default true, but you can change that. Check out keys for the options at
[More details on json_serializable](https://pub.dev/packages/json_serializable)

At the moment it is not possible to change destination path automatically, so unless you want source code to became dirty fast, you can move it manually.  