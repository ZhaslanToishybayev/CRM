/// Custom Exceptions
/// Educational Project - Gamified Task Management App
///
/// This file defines custom exceptions for better error handling:
/// - NetworkException
/// - AuthException
/// - DatabaseException
/// - ValidationException

import '../constants/app_constants.dart';

/// Base exception class
abstract class AppException implements Exception {
  final String message;
  final String code;

  const AppException(this.message, this.code);

  @override
  String toString() => '$code: $message';
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(String message)
      : super(message, AppConstants.errorNetwork);
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException(String message)
      : super(message, AppConstants.errorAuth);
}

/// Database-related exceptions
class DatabaseException extends AppException {
  const DatabaseException(String message)
      : super(message, AppConstants.errorDatabase);
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException(String message)
      : super(message, AppConstants.errorValidation);
}

/// Unknown exceptions
class UnknownException extends AppException {
  const UnknownException(String message)
      : super(message, AppConstants.errorUnknown);
}
