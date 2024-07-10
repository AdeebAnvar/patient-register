import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/models/patients_model.dart';

abstract class PatientsRepository {
  Future<ApiResponse<PatientsModel>> getPatients();
  Future<ApiResponse<Map<String, dynamic>>> registerPatient({
    required String name,
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
    required List<String> treatments,
  });
}
