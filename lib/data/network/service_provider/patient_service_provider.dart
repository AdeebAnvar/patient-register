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

  @override
  Future<ApiResponse<Map<String, dynamic>>> registerPatient(
      {required String name,
      required String executive,
      required String payment,
      required String phone,
      required String address,
      required int totalAmount,
      required int discountAmount,
      required int advanceAmount,
      required int balanceAmount,
      required String dateAndTime,
      required List<String> male,
      required List<String> feMale,
      required String branch,
      required List<String> treatments}) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();

      var data = FormData.fromMap({
        'name': name,
        'excecutive': executive,
        'payment': payment,
        'phone': phone,
        'address': address,
        'total_amount': totalAmount,
        'discount_amount': discountAmount,
        "advance_amount": advanceAmount,
        'balance_amount': balanceAmount,
        'date_nd_time': dateAndTime,
        'id': '',
        'male': male,
        'female': feMale,
        'branch': branch,
        'treatments': treatments,
      });
      Response<dynamic> response = await dio.post('PatientUpdate', options: Options(headers: authHeader), data: data);
      if (response.statusCode == 200 && response.data['status']) {
        Map<String, dynamic> resp = response.data;
        ;
        return ApiResponse.success(resp);
      } else {
        return ApiResponse.failed(response.data['message'].toString());
      }
    } catch (e) {
      return ApiResponse.failed(e.toString());
    }
  }
}
