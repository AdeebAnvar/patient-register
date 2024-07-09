import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/presentation/screens/register_patient.dart';
import 'package:novindus_mechine_test/widgets/custom_dropdown.dart';
import 'package:novindus_mechine_test/widgets/custom_textfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String route = '/home';
  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextQuery = TextEditingController();
    List<String> sortingDates = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        padding: EdgeInsets.all(20),
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
                    padding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    controller: searchTextQuery,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  style: AppStyles.filledButton.copyWith(
                      textStyle: WidgetStatePropertyAll(AppStyles.getMediumStyle(fontSize: 12)),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      fixedSize: WidgetStatePropertyAll(Size(0, 45))),
                  onPressed: () {},
                  child: Text('Search'),
                ),
              ),
            ],
          ),
          SizedBox(height: 28),
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
                ),
              )
            ],
          ),
          Divider(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (c, i) {
              return Card(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        '1. Vikram Singh',
                        style: AppStyles.getMediumStyle(fontSize: 15),
                      ),
                      subtitle: Text(
                        'Couple Combo Package (Rejuvennagar kdfsdfwrijuh',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.getLightStyle(fontSize: 16, fontColor: AppColors.textGreen),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, bottom: 10),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month, color: AppColors.appRed, size: 13),
                          SizedBox(width: 10),
                          Text(
                            '31/01/2024',
                            style: AppStyles.getRegularStyle(fontSize: 15),
                          ),
                          SizedBox(width: 20),
                          Icon(Icons.people_alt_outlined, color: AppColors.appRed, size: 13),
                          SizedBox(width: 10),
                          Text(
                            'Jithesh',
                            style: AppStyles.getRegularStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'View Booking details',
                        style: AppStyles.getLightStyle(fontSize: 16),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: TextButton(
          onPressed: () => context.pushNamed(RegisterPatient.route),
          style: AppStyles.filledButton.copyWith(
            padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
            fixedSize: WidgetStatePropertyAll(
              Size(MediaQuery.sizeOf(context).width, 50),
            ),
          ),
          child: Text('Register Now'),
        ),
      ),
    );
  }
}
