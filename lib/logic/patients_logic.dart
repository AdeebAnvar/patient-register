import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
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

  String manCount = '1';
  String femaleCount = '1';
  String selectedPayment = 'cash';
  bool cashPayment = true;
  bool cardPayment = false;
  bool upiPayment = false;

  List<Map<String, dynamic>> selectedTreatments = [];

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

  void addManCount(String value) {
    int count = int.parse(value);
    int v = count + 1;
    manCount = v.toString();
    notifyListeners();
  }

  void lessManCount(String value) {
    int count = int.parse(value);
    if (count > 1) {
      int v = count - 1;
      manCount = v.toString();
      notifyListeners();
    }
  }

  void addFemaleCount(String value) {
    int count = int.parse(value);
    int v = count + 1;
    femaleCount = v.toString();
    notifyListeners();
  }

  void lessFemaleCount(String value) {
    int count = int.parse(value);
    if (count > 1) {
      int v = count - 1;
      femaleCount = v.toString();
      notifyListeners();
    }
  }

  void addTreatment({
    required String treatement,
    required String male,
    required String female,
  }) {
    selectedTreatments.add({
      'treatment': treatement,
      'male': male,
      'female': female,
    });

    notifyListeners();
  }

  removeTreatment(int index) {
    selectedTreatments.removeAt(index);
    notifyListeners();
  }

  void editTreatment({
    required String treatement,
    required String male,
    required String female,
    required int index,
  }) {
    selectedTreatments[index] = {
      'treatment': treatement,
      'male': male,
      'female': female,
    };

    notifyListeners();
  }

  changePaymentMode(v, s) {
    if (s == 'cash') {
      cashPayment = true;
      cardPayment = false;
      upiPayment = false;
    } else if (s == 'card') {
      cashPayment = false;
      cardPayment = true;
      upiPayment = false;
    } else {
      cashPayment = false;
      cardPayment = false;
      upiPayment = true;
    }
    selectedPayment = s;
    print(selectedPayment);
    notifyListeners();
  }

  Future<void> registerPatient(
    BuildContext context, {
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
  }) async {
    loadingDialogue(context);
    var res = await patientsRepository.registerPatient(
        name: name,
        executive: executive,
        payment: payment,
        phone: phone,
        address: address,
        totalAmount: totalAmount,
        discountAmount: discountAmount,
        advanceAmount: advanceAmount,
        balanceAmount: balanceAmount,
        dateAndTime: dateAndTime,
        male: male,
        feMale: feMale,
        branch: branch,
        treatments: treatments);
    context.pop();
  }

  loadingDialogue(BuildContext c) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: c,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SpinKitFadingCircle(
              color: AppColors.primary,
              size: 50.0,
            ),
          );
        });
  }
}
