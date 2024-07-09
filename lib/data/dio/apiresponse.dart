import 'package:novindus_mechine_test/constatnts/enums.dart';

class ApiResponse<T> {
  ApiResponse.failed(this.message) : status = ApiResponseStatus.failed;
  ApiResponse.success(this.data) : status = ApiResponseStatus.success;
  String? message;
  ApiResponseStatus status;
  T? data;
}
