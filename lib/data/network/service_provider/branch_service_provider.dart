import 'package:dio/dio.dart';
import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/dio/dio_client.dart';
import 'package:novindus_mechine_test/data/models/branch_model.dart';
import 'package:novindus_mechine_test/data/network/repository/branch_repository.dart';

class BranchServiceProvider extends BranchRepository {
  Dio dio = Client().init();
  @override
  Future<ApiResponse<BranchModel>> getAllBranches() async {
    try {
      Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      var response = await dio.get('BranchList', options: Options(headers: authHeader));
      if (response.statusCode == 200 && response.data['status']) {
        BranchModel branchModel = BranchModel.fromJson(response.data);
        return ApiResponse.success(branchModel);
      } else {
        return ApiResponse.failed(response.data['message']);
      }
    } catch (e) {
      return ApiResponse.failed(e.toString());
    }
  }
}
