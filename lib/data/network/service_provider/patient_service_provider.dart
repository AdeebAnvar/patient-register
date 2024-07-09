import 'package:dio/dio.dart';
import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/dio/dio_client.dart';
import 'package:novindus_mechine_test/data/models/patients_model.dart';
import 'package:novindus_mechine_test/data/network/repository/patients_repository.dart';

class PatientServiceProvider extends PatientsRepository {
  Dio dio = Client().init();
  @override
  Future<ApiResponse<PatientsModel>> getPatients() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      Response<dynamic> response = await dio.get(
        'PatientList',
        options: Options(headers: authHeader),
      );
      if (response.statusCode == 200 && response.data['status']) {
        PatientsModel patientsModel = PatientsModel.fromJson(response.data);
        return ApiResponse.success(patientsModel);
      } else {
        return ApiResponse.failed(response.data['message'].toString());
      }
    } catch (e) {
      return ApiResponse.failed(e.toString());
    }
  }
}
