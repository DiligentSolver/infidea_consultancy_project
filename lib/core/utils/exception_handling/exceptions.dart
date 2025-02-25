class NoInternetException implements Exception {
  final String message;
  NoInternetException([this.message = "No Internet Connection."]);

  @override
  String toString() => message;
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException([this.message = "Invalid request."]);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = "Session expired. Please login again."]);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException([this.message = "Resource not found."]);

  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Server error. Please try again later."]);

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;
  UnknownException([this.message = "Something went wrong."]);

  @override
  String toString() => message;
}
