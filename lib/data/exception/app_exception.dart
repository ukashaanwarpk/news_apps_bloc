class AppException implements Exception {
  final String? _message;
  final String _prefix;
  AppException([this._message, this._prefix = '']);

  @override
  String toString() {
    // If _message is null or empty, return only the prefix.
    if (_message == null || _message.isEmpty) {
      return _prefix;
    }
    return '$_message: $_prefix';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
    : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
    : super(message, 'No Internet Connection');
}
