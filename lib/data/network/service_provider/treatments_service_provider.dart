import 'package:dio/dio.dart';
import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/dio/dio_client.dart';
import 'package:novindus_mechine_test/data/models/treatments_model.dart';
import 'package:novindus_mechine_test/data/network/repository/treatments_repository.dart';

class TreatmentsServiceProvider extends TreatmentsRepository {
  Dio dio = Client().init();
  @override
  Future<ApiResponse<TreatmentsModel>> getAllTreatments() async {
    try {
      Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      var response = await dio.get('TreatmentList', options: Options(headers: authHeader));
      if (response.statusCode == 200 && response.data['status']) {
        TreatmentsModel treatmentsModel = TreatmentsModel.fromJson(response.data);
        return ApiResponse.success(treatmentsModel);
      } else {
        return ApiResponse.failed(response.data['message']);
      }
    } catch (e) {
      return ApiResponse.failed(e.toString());
    }
  }
}
