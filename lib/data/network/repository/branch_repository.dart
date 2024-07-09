import 'package:novindus_mechine_test/data/dio/apiresponse.dart';
import 'package:novindus_mechine_test/data/models/branch_model.dart';

abstract class BranchRepository {
  Future<ApiResponse<BranchModel>> getAllBranches();
}
