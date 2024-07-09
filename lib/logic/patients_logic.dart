import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/enums.dart';
import 'package:novindus_mechine_test/data/models/patients_model.dart';
import 'package:novindus_mechine_test/data/network/repository/patients_repository.dart';
import 'package:novindus_mechine_test/data/network/service_provider/patient_service_provider.dart';

class PatientsLogic extends ChangeNotifier {
  PatientsRepository patientsRepository = PatientServiceProvider();
  bool isLoading = false;
  bool isError = false;
  PatientsModel patients = PatientsModel();
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
}
