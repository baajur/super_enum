import 'package:source_gen_test/source_gen_test.dart';
import 'package:super_enum/super_enum.dart';

@ShouldGenerate(r'''
@immutable
abstract class Result<T> extends Equatable {
  const Result(this._type);

  factory Result.success({@required T data, @required String message}) =
      Success<T>.create;

  factory Result.error() = Error<T>.create;

  final _Result _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Success<T>) success,
      @required R Function() error}) {
    assert(() {
      if (success == null || error == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Result.Success:
        return success(this as Success);
      case _Result.Error:
        return error();
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Success<T>) success,
      @required FutureOr<R> Function() error}) {
    assert(() {
      if (success == null || error == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Result.Success:
        return success(this as Success);
      case _Result.Error:
        return error();
    }
  }

  R whenOrElse<R>(
      {R Function(Success<T>) success,
      R Function() error,
      @required R Function(Result<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Result.Success:
        if (success == null) break;
        return success(this as Success);
      case _Result.Error:
        if (error == null) break;
        return error();
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Success<T>) success,
      FutureOr<R> Function() error,
      @required FutureOr<R> Function(Result<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Result.Success:
        if (success == null) break;
        return success(this as Success);
      case _Result.Error:
        if (error == null) break;
        return error();
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Success<T>) success,
      FutureOr<void> Function() error}) {
    assert(() {
      if (success == null && error == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Result.Success:
        if (success == null) break;
        return success(this as Success);
      case _Result.Error:
        if (error == null) break;
        return error();
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class Success<T> extends Result<T> {
  const Success({@required this.data, @required this.message})
      : super(_Result.Success);

  factory Success.create({@required T data, @required String message}) =
      _SuccessImpl<T>;

  final T data;

  final String message;

  Success<T> copyWith({T data, String message});
}

@immutable
class _SuccessImpl<T> extends Success<T> {
  const _SuccessImpl({@required this.data, @required this.message})
      : super(data: data, message: message);

  @override
  final T data;

  @override
  final String message;

  @override
  _SuccessImpl<T> copyWith(
          {Object data = superEnum, Object message = superEnum}) =>
      _SuccessImpl(
        data: data == superEnum ? this.data : data as T,
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'Success(data: ${this.data}, message: ${this.message})';
  @override
  List<Object> get props => [data, message];
}

@immutable
abstract class Error<T> extends Result<T> {
  const Error() : super(_Result.Error);

  factory Error.create() = _ErrorImpl<T>;
}

@immutable
class _ErrorImpl<T> extends Error<T> {
  const _ErrorImpl() : super();

  @override
  String toString() => 'Error()';
}
''')
@superEnum
// ignore: unused_element
enum _Result {
  @generic
  @Data(fields: [
    DataField<Generic>('data'),
    DataField<String>('message'),
  ])
  Success,

  @object
  Error,
}
