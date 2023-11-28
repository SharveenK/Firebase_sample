import 'package:equatable/equatable.dart';

class ErrorController extends Equatable {
  final String error;
  final String message;
  final String plugin;
  const ErrorController({
    this.error = '',
    this.message = '',
    this.plugin = '',
  });

  @override
  List<Object?> get props => [error, message, plugin];
}
