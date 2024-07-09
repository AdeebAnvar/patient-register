import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/models/user_model.dart';

abstract class LoginRepository {
  Future<ApiResponse<UserModel>> login({required String userName, required String passWord});
}
