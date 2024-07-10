import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';

class TreatmentCard extends StatelessWidget {
  const TreatmentCard({
    super.key,
    required this.maleCount,
    required this.femaleCount,
    required this.number,
    required this.name,
    required this.onRemove,
    required this.onEdit,
  });

  final String maleCount;
  final String femaleCount;
  final String number;
  final String name;
  final void Function() onRemove;
  final void Function() onEdit;
  @override
  Widget build(BuildContext context) {
    TextEditingController maleCountController = TextEditingController(text: maleCount);
    TextEditingController femaleController = TextEditingController(text: femaleCount);
    return Card(
      surfaceTintColor: Colors.transparent,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '$number. $name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.getSemiBoldStyle(fontSize: 18),
              ),
              trailing: GestureDetector(
                onTap: onRemove,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.appRed,
                  child: const Icon(size: 20, Icons.close, color: Colors.white),
                ),
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
                  GestureDetector(onTap: onEdit, child: Icon(Icons.edit, color: AppColors.primary))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
