import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/models/patients_model.dart';

abstract class PatientsRepository {
  Future<ApiResponse<PatientsModel>> getPatients();
}
