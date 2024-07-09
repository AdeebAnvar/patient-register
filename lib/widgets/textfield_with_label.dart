import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/styles.dart';
import 'package:novindus_mechine_test/widgets/custom_textfield.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel(
      {super.key, required this.controller, required this.hint, required this.label, this.suffix, this.validator, this.obscureText = false, this.onChanged, this.onTap});
  final TextEditingController controller;
  final String hint;
  final String label;
  final Widget? suffix;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final Function(String value)? onChanged;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.getRegularStyle(fontSize: 16),
        ),
        SizedBox(height: 5.98),
        CustomTextField(
          obscureText: obscureText,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          controller: controller,
          hint: hint,
          fillColor: Colors.grey.shade200,
          suffix: suffix,
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        ),
      ],
    );
  }
}
