import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDownButtonField<T> extends StatelessWidget {
  const CustomDropDownButtonField({
    super.key,
    this.value,
    required this.items,
    required this.hint,
    this.border,
    this.focusedBorder,
    this.validator,
    this.onChanged,
    this.fillColor,
    this.icon,
  });
  final T? value;
  final List<T> items;
  final String hint;
  final OutlineInputBorder? border;
  final OutlineInputBorder? focusedBorder;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final Color? fillColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.white,
        filled: true,
        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),
        border: border ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(25),
            ),
        enabledBorder: border ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(25),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(25),
            ),
      ),
      borderRadius: border == null ? BorderRadius.circular(25) : BorderRadius.circular(10),
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      icon: icon,
      value: value,
      items: items.map((i) {
        return DropdownMenuItem<T>(
          value: i,
          child: Text(i.toString()),
        );
      }).toList(),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
