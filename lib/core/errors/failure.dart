import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/core/errors/exception.dart';

abstract class Failure extends Equatable {
  const Failure({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [statusCode, message];
}

class APIFailure extends Failure {
  const APIFailure({required super.statusCode, required super.message});

  APIFailure.fromException(APIException exception) : this(
      statusCode: exception.statusCode,
      message: exception.message,
  );
}