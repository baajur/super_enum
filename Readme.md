<img src="https://user-images.githubusercontent.com/25670178/68855928-5590b800-0705-11ea-98f2-43f98fb5b06e.png?sanitize=true" width="500px">

[![Dart CI](https://github.com/xsahil03x/super_enum/workflows/Dart%20CI/badge.svg)](https://github.com/xsahil03x/super_enum/actions) [![codecov](https://codecov.io/gh/xsahil03x/super_enum/branch/master/graph/badge.svg)](https://codecov.io/gh/xsahil03x/super_enum) [![Version](https://img.shields.io/pub/v/super_enum?label=super_enum)](https://pub.dartlang.org/packages/super_enum) [![Version](https://img.shields.io/pub/v/super_enum?label=super_enum_generator)](https://pub.dartlang.org/packages/super_enum_generator) 

*Super-powered enums similar to sealed classes in Kotlin*

## Installation
Add the following to you `pubspec.yaml` and replace `[version]` with the latest version:

```dart
dependencies:
  super_enum: ^[version]

dev_dependencies:
  super_enum_generator: ^[version]
  build_runner: ^1.7.1 // Any latest version which works with your current Dart or Flutter SDK
```

## Example

A Super Enum can be easily generated by annotating a private enum with `@superEnum`
```dart
import 'package:super_enum/super_enum.dart';

part "result.g.dart";

@superEnum
enum _Result {
  @generic
  @Data(fields: [
    DataField('data', Generic),
    DataField('message', String),
  ])
  Success,

  @object
  Error,
}
```

`@Data()` marks an enum value to be treated as a Data class.
 * One should supply a list of possible fields inside the annotation.
 * If you don't want to add fields, use `@object` annotation instead.
 * Fields are supplied in the form of `DataField` objects. 
 * Each `DataField` must contain the `name` and the `type` of the field.
 * If the field type needs to be generic use `Generic` type and annotate the enum value with `@generic` annotation.

`@object` marks an enum value to be treated as an object.

Run the `build_runner` command to generate the `filename.g.dart` part file.
```dart
 # Dart SDK: $pub run build_runner build
 # Flutter SDK: $flutter pub run build_runner build
```

## Generated file
```dart
@immutable
abstract class Result<T> {
  const Result(this._type);

  factory Result.success({@required T data, @required String message}) =
      Success<T>;

  factory Result.error() = Error<T>;

  final _Result _type;

  R when<R>(
      {@required R Function(Success) onSuccess,
      @required R Function(Error) onError}) {
    switch (this._type) {
      case _Result.Success:
        return onSuccess(this as Success);
      case _Result.Error:
        return onError(this as Error);
    }
  }
}

@immutable
class Success<T> extends Result<T> {
  const Success({@required this.data, @required this.message})
      : super(_Result.Success);

  final T data;

  final String message;
}

@immutable
class Error<T> extends Result<T> {
  const Error() : super(_Result.Error);
}
```

## Usage
Below is just one of the use-case of `Super Enums`. It can be used wherever you want to manage state.

```dart
// Creating an StreamController of type Result<int>
final _resultController = StreamController<Result<int>>();

// Adding a success state to the stream controller
_resultController.add(Result.success(
              data: 333,
              message: 'Success',
            )),

// Adding an error state to the stream controller
_resultController.add(Result.error()),

// Listening to all the possible Result states
_resultController.stream.listen((result) {
      result.when(
        onSuccess: (data) => print(data.message), // Success
        onError: (_) => print('Error Occured'), // Error Occured
      );
    });
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.