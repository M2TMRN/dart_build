# Code generation with Dart build system

## Getting Started
[Base source: Kevin Moore](https://www.youtube.com/watch?v=iVoz7kJoLFQ)

## Initial pubspec.yaml
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


## Build version
Add dev dependency:
```
build_version: ^2.0.1 # has builder inside
```

``` shell script  
pub run build_runner
```

If build_runner file not found try [source](https://github.com/dart-lang/build/issues/2581): 
 1. Be sure that you are in correct folder (where pubspec.yaml is);
 2. Use following commands instead of the above

* Run at the start to generate version
``` shell script
flutter pub get
flutter packages get
flutter packages pub run build_runner build
```

* Run to update version
``` shell script
flutter packages pub run build_runner watch
```
Generates and later updates src/version.dart from version in pubspec.yaml file. Version is updated every time it is changed in pubspec.yaml, while watch is on.


** Cancel watch. **

### JSON handling
* Add src/customer.dart

* Update pubspec.yaml
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
* Json mapper class is generated as src/customer.g.dart

[More details on json_serializable](https://pub.dev/packages/json_serializable)
  