import 'package:dio/dio.dart';
import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/dio/dio_client.dart';
import 'package:novindus_mechine_test/data/models/user_model.dart';
import 'package:novindus_mechine_test/data/network/repository/login_repository.dart';

class LoginServiceProvider extends LoginRepository {
  Dio dio = Client().init();
  @override
  Future<ApiResponse<UserModel>> login({required String userName, required String passWord}) async {
    try {
      FormData data = FormData.fromMap({'username': userName, 'password': passWord});

      Response<dynamic> response = await dio.post('Login', data: data);

      if (response.statusCode == 200 && response.data['status']) {
        UserModel userModel = UserModel.fromJson(response.data);
        return ApiResponse<UserModel>.success(userModel);
      } else {
        return ApiResponse<UserModel>.failed(response.data['message']);
      }
    } catch (e) {
      return ApiResponse.failed(e.toString());
    }
  }
}
