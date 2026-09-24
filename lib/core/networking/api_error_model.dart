class ApiErrorModel {
  int? status;
  String? message;
  bool? succeeded;
  Errors? errors;

  ApiErrorModel({
    this.status,
    this.message,
    this.succeeded,
    this.errors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      status: json["status"] as int? ?? json["statusCode"] as int? ?? json["code"] as int?,
      message: json["message"] as String? ?? json["error"] as String?,
      succeeded: json["succeeded"] as bool?,
      errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    );
  }

  /// Extracted first available error message from message or errors map
  String get firstErrorMessage {
    if (message != null && message!.trim().isNotEmpty) {
      return message!;
    }
    if (errors != null) {
      final firstErr = errors!.firstError;
      if (firstErr != null && firstErr.trim().isNotEmpty) {
        return firstErr;
      }
    }
    return 'An error occurred. Please try again.';
  }
}

class Errors {
  List<String>? email;
  List<String>? userName;
  List<String>? fullName;
  List<String>? password;
  List<String>? confirmPassword;
  List<String>? phoneNumber;
  List<String>? code;

  // Generic map to catch any other field errors returned by the API
  Map<String, List<String>>? errorMap;

  Errors({
    this.email,
    this.userName,
    this.fullName,
    this.password,
    this.confirmPassword,
    this.phoneNumber,
    this.code,
    this.errorMap,
  });

  factory Errors.fromJson(dynamic json) {
    if (json is Map) {
      final Map<String, List<String>> parsedMap = {};

      json.forEach((key, value) {
        final String keyString = key.toString();
        if (value is List) {
          parsedMap[keyString] = List<String>.from(value.map((e) => e.toString()));
        } else if (value != null) {
          parsedMap[keyString] = [value.toString()];
        }
      });

      return Errors(
        email: parsedMap['email'] ?? parsedMap['Email'],
        userName: parsedMap['userName'] ?? parsedMap['UserName'] ?? parsedMap['username'],
        fullName: parsedMap['fullName'] ?? parsedMap['FullName'] ?? parsedMap['fullname'],
        password: parsedMap['password'] ?? parsedMap['Password'],
        confirmPassword: parsedMap['confirmPassword'] ?? parsedMap['ConfirmPassword'],
        phoneNumber: parsedMap['phoneNumber'] ?? parsedMap['PhoneNumber'] ?? parsedMap['phone'],
        code: parsedMap['code'] ?? parsedMap['Code'],
        errorMap: parsedMap,
      );
    } else if (json is List) {
      final list = List<String>.from(json.map((e) => e.toString()));
      return Errors(errorMap: {'general': list});
    }
    return Errors();
  }

  /// Returns the first error message across all fields
  String? get firstError {
    if (errorMap != null && errorMap!.isNotEmpty) {
      for (var entry in errorMap!.entries) {
        if (entry.value.isNotEmpty) {
          return entry.value.first;
        }
      }
    }
    return null;
  }
}
