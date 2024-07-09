import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/enums.dart';
import 'package:novindus_mechine_test/data/models/branch_model.dart';
import 'package:novindus_mechine_test/data/models/patients_model.dart';
import 'package:novindus_mechine_test/data/models/treatments_model.dart';
import 'package:novindus_mechine_test/data/network/repository/branch_repository.dart';
import 'package:novindus_mechine_test/data/network/repository/patients_repository.dart';
import 'package:novindus_mechine_test/data/network/repository/treatments_repository.dart';
import 'package:novindus_mechine_test/data/network/service_provider/branch_service_provider.dart';
import 'package:novindus_mechine_test/data/network/service_provider/patient_service_provider.dart';
import 'package:novindus_mechine_test/data/network/service_provider/treatments_service_provider.dart';

class PatientsLogic extends ChangeNotifier {
  PatientsRepository patientsRepository = PatientServiceProvider();
  TreatmentsRepository treatmentsRepository = TreatmentsServiceProvider();
  BranchRepository branchRepository = BranchServiceProvider();

  bool isLoading = false;
  bool isError = false;

  PatientsModel patients = PatientsModel();
  TreatmentsModel treatmentsModel = TreatmentsModel();
  BranchModel branchModel = BranchModel();

  Future<void> getAllPatients() async {
    isLoading = true;

    var response = await patientsRepository.getPatients();
    if (response.status == ApiResponseStatus.success && response.data!.patient!.isNotEmpty) {
      patients = response.data!;
      isLoading = false;
      notifyListeners();
    } else {
      isError = true;
      isLoading = false;
      notifyListeners();
    }
  }

  getRegisterScreenData() async {
    isLoading = true;
    await getTreatments().then((v) async {
      await getBranches().then((v) {
        isLoading = false;
        notifyListeners();
      });
    });
  }

  Future<void> getTreatments() async {
    var response = await treatmentsRepository.getAllTreatments();
    if (response.status == ApiResponseStatus.success && response.data!.treatments!.isNotEmpty) {
      treatmentsModel = response.data!;
    }
  }

  Future<void> getBranches() async {
    var response = await branchRepository.getAllBranches();
    if (response.status == ApiResponseStatus.success && response.data!.branches!.isNotEmpty) {
      branchModel = response.data!;
    }
  }
}
