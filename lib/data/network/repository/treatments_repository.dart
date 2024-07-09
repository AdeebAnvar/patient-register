import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/models/treatments_model.dart';

abstract class TreatmentsRepository {
  Future<ApiResponse<TreatmentsModel>> getAllTreatments();
}
