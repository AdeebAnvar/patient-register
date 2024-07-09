import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/widgets/custom_dropdown.dart';
import 'package:novindus_mechine_test/widgets/custom_textfield.dart';
import 'package:novindus_mechine_test/widgets/textfield_with_label.dart';

class RegisterPatient extends StatelessWidget {
  const RegisterPatient({super.key});
  static String route = '/register_patient';
  @override
  Widget build(BuildContext context) {
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
    String location;
    String treatmentHour;
    String treatmentMinute;
    String branch;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              Align(
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Register',
              style: AppStyles.getSemiBoldStyle(fontSize: 24),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWithLabel(
                  controller: nameController,
                  hint: 'Enter your full name',
                  label: 'Name',
                ),
                SizedBox(height: 20),
                TextFieldWithLabel(
                  controller: whatsappNumberController,
                  hint: 'Enter your whatsapp number',
                  label: 'Whatsapp Number',
                ),
                SizedBox(height: 20),
                TextFieldWithLabel(
                  controller: addressController,
                  hint: 'Enter your full address',
                  label: 'Address',
                ),
                SizedBox(height: 20),
                Text(
                  'Location',
                  style: AppStyles.getRegularStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                CustomDropDownButtonField(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey.shade200,
                  items: ['Cochin', 'Kasargode', 'Palakkad'],
                  hint: 'Choose your Location',
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                  onChanged: (v) {
                    location = v!;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Branch',
                  style: AppStyles.getRegularStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                CustomDropDownButtonField(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey.shade200,
                  items: ['Cochin', 'Kasargode', 'Palakkad'],
                  hint: 'Selct the branch',
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                  onChanged: (v) {
                    branch = v!;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Treatments',
                  style: AppStyles.getRegularStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Card(
                  surfaceTintColor: Colors.transparent,
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '1. Couple compo package inside vertibular',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.getSemiBoldStyle(fontSize: 18),
                          ),
                          trailing: CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.appRed,
                            child: Icon(size: 20, Icons.close, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              Expanded(child: Text('Male', style: AppStyles.getRegularStyle(fontSize: 16, fontColor: AppColors.lightGreen))),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  controller: maleCountController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(child: Text('Female', style: AppStyles.getRegularStyle(fontSize: 16, fontColor: AppColors.lightGreen))),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  controller: femaleController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.edit, color: AppColors.primary)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton.icon(
                  onPressed: () => addTreatMents(context),
                  style: AppStyles.filledButton.copyWith(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    )),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                    backgroundColor: WidgetStatePropertyAll(AppColors.lightGreen.withOpacity(0.3)),
                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.sizeOf(context).width, 50),
                    ),
                  ),
                  icon: Icon(Icons.add),
                  label: Text('Add Treatments'),
                ),
                SizedBox(height: 20),
                TextFieldWithLabel(
                  controller: totalAmountController,
                  label: 'Total Amount',
                  hint: '',
                ),
                SizedBox(height: 20),
                TextFieldWithLabel(
                  controller: discountAmountController,
                  label: 'Discount Amount',
                  hint: '',
                ),
                SizedBox(height: 20),
                Text(
                  'Payment Option',
                  style: AppStyles.getRegularStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
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
                SizedBox(height: 20),
                TextFieldWithLabel(
                  controller: advanceAmountController,
                  label: 'Advance Amount',
                  hint: '',
                ),
                SizedBox(height: 20),
                TextFieldWithLabel(
                  controller: balanceAmountController,
                  label: 'Balance Amount',
                  hint: '',
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                Text(
                  'Treament Time',
                  style: AppStyles.getRegularStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
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
                    SizedBox(width: 20),
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  style: AppStyles.filledButton.copyWith(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.sizeOf(context).width, 50),
                    ),
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  addTreatMents(BuildContext context) {
    TextEditingController chooseTreatmentController = TextEditingController();
    TextEditingController maleController = TextEditingController();
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
                    SizedBox(height: 10),
                    CustomDropDownButtonField(
                      fillColor: Colors.grey.shade200,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      items: ['Injection', 'vaccine', 'oxygen'],
                      hint: 'Choose Prefered Treatment',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add Patients',
                      style: AppStyles.getRegularStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
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
                              child: Center(
                                child: Text('Male'),
                              ),
                            )),
                        SizedBox(width: 10),
                        CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: maleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                              child: Center(
                                child: Text('Fe Male'),
                              ),
                            )),
                        SizedBox(width: 10),
                        CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: maleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      style: AppStyles.filledButton.copyWith(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                        fixedSize: WidgetStatePropertyAll(
                          Size(MediaQuery.sizeOf(context).width, 50),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
