import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.number,
    this.name,
    this.treatmentName,
    this.user,
    required this.createdate,
  });
  final String number;
  final String? name;
  final String? treatmentName;
  final String? user;
  final String createdate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '$number. $name',
              style: AppStyles.getMediumStyle(fontSize: 15),
            ),
            subtitle: Text(
              treatmentName ?? '',
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
                const SizedBox(width: 10),
                Text(
                  createdate,
                  style: AppStyles.getRegularStyle(fontSize: 15),
                ),
                const SizedBox(width: 20),
                Icon(Icons.people_alt_outlined, color: AppColors.appRed, size: 13),
                const SizedBox(width: 10),
                Text(
                  user ?? '',
                  style: AppStyles.getRegularStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              'View Booking details',
              style: AppStyles.getLightStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
