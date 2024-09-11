import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.statusCode, required super.message});
}