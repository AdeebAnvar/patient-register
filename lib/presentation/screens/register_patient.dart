import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/logic/patients_logic.dart';
import 'package:novindus_mechine_test/presentation/screens/pdf_viewing_screen.dart';
import 'package:novindus_mechine_test/widgets/creat_pdf.dart';
import 'package:novindus_mechine_test/widgets/custom_dropdown.dart';
import 'package:novindus_mechine_test/widgets/custom_textfield.dart';
import 'package:novindus_mechine_test/widgets/textfield_with_label.dart';
import 'package:novindus_mechine_test/widgets/treatment_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({super.key});
  static String route = '/register_patient';

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  PatientsLogic patientsLogic = PatientsLogic();
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController maleCountController = TextEditingController();
  TextEditingController femaleController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController advanceAmountController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();
  TextEditingController treatmentDateController = TextEditingController();

  String? location;
  String? treatmentHour;
  String? treatmentMinute;
  String? branch;
  @override
  void initState() {
    patientsLogic = Provider.of<PatientsLogic>(context, listen: false);
    getData();
    super.initState();
  }

  getData() async {
    await patientsLogic.getRegisterScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientsLogic>(
      builder: (context, pl, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Stack(
                children: [
                  const Align(
                    child: Icon(
                      Icons.notifications_none,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 16,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(color: AppColors.appRed, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: pl.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Register',
                        style: AppStyles.getSemiBoldStyle(fontSize: 24),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldWithLabel(
                            controller: nameController,
                            hint: 'Enter your full name',
                            label: 'Name',
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: whatsappNumberController,
                            hint: 'Enter your whatsapp number',
                            label: 'Whatsapp Number',
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: addressController,
                            hint: 'Enter your full address',
                            label: 'Address',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Location',
                            style: AppStyles.getRegularStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          CustomDropDownButtonField(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.grey.shade200,
                            items: ['Cochin', 'Kasargode', 'Palakkad'],
                            hint: 'Choose your Location',
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            onChanged: (v) {
                              location = v!;
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Branch',
                            style: AppStyles.getRegularStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          pl.branchModel.branches!.isEmpty
                              ? const SizedBox()
                              : CustomDropDownButtonField(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide.none,
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  items: pl.branchModel.branches!.map((e) => e.name).toList(),
                                  hint: 'Selct the branch',
                                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                                  onChanged: (v) {
                                    branch = v!;
                                  },
                                ),
                          const SizedBox(height: 20),
                          Text(
                            'Treatments',
                            style: AppStyles.getRegularStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          TreatmentCard(
                            maleCountController: maleCountController,
                            femaleController: femaleController,
                          ),
                          const SizedBox(height: 20),
                          TextButton.icon(
                            onPressed: () => treatMentDialogue(
                              context,
                              'add',
                              pl.treatmentsModel.treatments!.map((e) => e.name!).toList(),
                            ),
                            style: AppStyles.filledButton.copyWith(
                              padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              )),
                              foregroundColor: const WidgetStatePropertyAll(Colors.black),
                              backgroundColor: WidgetStatePropertyAll(AppColors.lightGreen.withOpacity(0.3)),
                              fixedSize: WidgetStatePropertyAll(
                                Size(MediaQuery.sizeOf(context).width, 50),
                              ),
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text('Add Treatments'),
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: totalAmountController,
                            label: 'Total Amount',
                            hint: '',
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: discountAmountController,
                            label: 'Discount Amount',
                            hint: '',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Payment Option',
                            style: AppStyles.getRegularStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: true,
                                      groupValue: true,
                                      onChanged: (v) {},
                                    ),
                                    Text(
                                      'Cash',
                                      style: AppStyles.getRegularStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: false,
                                      groupValue: true,
                                      onChanged: (v) {},
                                    ),
                                    Text(
                                      'Card',
                                      style: AppStyles.getRegularStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: false,
                                      groupValue: true,
                                      onChanged: (v) {},
                                    ),
                                    Text(
                                      'UPI',
                                      style: AppStyles.getRegularStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: advanceAmountController,
                            label: 'Advance Amount',
                            hint: '',
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: balanceAmountController,
                            label: 'Balance Amount',
                            hint: '',
                          ),
                          const SizedBox(height: 20),
                          TextFieldWithLabel(
                            controller: treatmentDateController,
                            label: 'Treatment Date',
                            hint: '',
                            onTap: () {},
                            suffix: Icon(
                              Icons.date_range,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Treament Time',
                            style: AppStyles.getRegularStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropDownButtonField(
                                  fillColor: Colors.grey.shade200,
                                  items: List.generate(24, (i) => '${i + 1}'),
                                  hint: 'Hours',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide.none,
                                  ),
                                  onChanged: (v) {
                                    treatmentHour = v!;
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: CustomDropDownButtonField(
                                  fillColor: Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide.none,
                                  ),
                                  items: List.generate(60, (i) => '${i + 1}'),
                                  hint: 'Minutes',
                                  onChanged: (v) {
                                    treatmentMinute = v!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => createPdf(context),
                            style: AppStyles.filledButton.copyWith(
                              padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                              fixedSize: WidgetStatePropertyAll(
                                Size(MediaQuery.sizeOf(context).width, 50),
                              ),
                            ),
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  treatMentDialogue(
    BuildContext context,
    String operation,
    List<String> treatments, {
    String? selectedTreatment,
    String? maleCount,
    String? femaleCount,
  }) {
    TextEditingController maleController = TextEditingController();
    String chosenTreatment;
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            content: Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Choose Treatment',
                      style: AppStyles.getRegularStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    CustomDropDownButtonField(
                      fillColor: Colors.grey.shade200,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 10,
                        color: AppColors.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      items: treatments,
                      hint: 'Choose Prefered Treatment',
                      onChanged: (v) {
                        chosenTreatment = v!;
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Add Patients',
                      style: AppStyles.getRegularStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: const Center(
                                child: Text('Male'),
                              ),
                            )),
                        const SizedBox(width: 10),
                        CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: const Text(
                              '-',
                              style: TextStyle(color: Colors.white),
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: maleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              child: const Center(
                                child: Text('Fe Male'),
                              ),
                            )),
                        const SizedBox(width: 10),
                        CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: const Text(
                              '-',
                              style: TextStyle(color: Colors.white),
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: maleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      style: AppStyles.filledButton.copyWith(
                        padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                        fixedSize: WidgetStatePropertyAll(
                          Size(MediaQuery.sizeOf(context).width, 50),
                        ),
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    patientsLogic.dispose();
    super.dispose();
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black}) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
