import 'package:news_apps_bloc/utils/enums.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse({this.status, this.data, this.message});

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.success;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'ApiResponse{status: $status, data: $data, message: $message}';
  }
}
