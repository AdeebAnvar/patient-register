import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/date_utils.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/logic/patients_logic.dart';
import 'package:novindus_mechine_test/presentation/screens/register_patient.dart';
import 'package:novindus_mechine_test/widgets/custom_dropdown.dart';
import 'package:novindus_mechine_test/widgets/custom_textfield.dart';
import 'package:novindus_mechine_test/widgets/patient_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextQuery = TextEditingController();
  List<String> sortingDates = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
  PatientsLogic patientsLogic = PatientsLogic();
  @override
  void initState() {
    patientsLogic = Provider.of<PatientsLogic>(context, listen: false);
    getData();
    super.initState();
  }

  getData() async {
    await patientsLogic.getAllPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientsLogic>(builder: (context, np, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
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
        body: np.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : np.isError
                ? Center(
                    child: Text(
                      'Data not found',
                      style: AppStyles.getBoldStyle(fontSize: 20),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => np.getAllPatients(),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Material(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CustomTextField(
                                  prefix: SvgPicture.asset(
                                    'assets/images/svg/search.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hint: 'Search for treatments',
                                  padding: const EdgeInsets.all(10),
                                  fillColor: Colors.white,
                                  controller: searchTextQuery,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextButton(
                                style: AppStyles.filledButton.copyWith(
                                    textStyle: WidgetStatePropertyAll(AppStyles.getMediumStyle(fontSize: 12)),
                                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                                    fixedSize: const WidgetStatePropertyAll(Size(0, 45))),
                                onPressed: () {},
                                child: const Text('Search'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Sort by :',
                                style: AppStyles.getMediumStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: CustomDropDownButtonField<String>(
                                hint: 'Date',
                                items: sortingDates,
                                onChanged: (v) {},
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: np.patients.patient!.length,
                          itemBuilder: (c, i) {
                            return PatientCard(
                              number: '${i + 1}',
                              name: np.patients.patient![i].name,
                              treatmentName: np.patients.patient![i].patientdetailsSet!.isEmpty ? '' : np.patients.patient![i].patientdetailsSet![0].treatmentName,
                              createdate: np.patients.patient![i].createdAt!.toDate(),
                              user: np.patients.patient![i].user,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: TextButton(
            onPressed: () => context.pushNamed(RegisterPatient.route),
            style: AppStyles.filledButton.copyWith(
              padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
              fixedSize: WidgetStatePropertyAll(
                Size(MediaQuery.sizeOf(context).width, 50),
              ),
            ),
            child: const Text('Register Now'),
          ),
        ),
      );
    });
  }
}
