import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';

class TreatmentCard extends StatelessWidget {
  const TreatmentCard({
    super.key,
    required this.maleCountController,
    required this.femaleController,
  });

  final TextEditingController maleCountController;
  final TextEditingController femaleController;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: const Icon(size: 20, Icons.close, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(child: Text('Male', style: AppStyles.getRegularStyle(fontSize: 16, fontColor: AppColors.lightGreen))),
                  Expanded(
                    child: TextField(
                      enabled: false,
                      controller: maleCountController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Female', style: AppStyles.getRegularStyle(fontSize: 16, fontColor: AppColors.lightGreen))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      enabled: false,
                      controller: femaleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.edit, color: AppColors.primary)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
