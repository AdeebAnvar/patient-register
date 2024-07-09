import 'dart:math';

import 'package:flutter/material.dart';
import 'package:novindus_mechine_test/constatnts/app_colors.dart';

class AppStyles {
  static TextStyle getExtraBoldStyle({required double fontSize, Color fontColor = Colors.black}) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: fontColor,
        fontWeight: FontWeight.w800,
      );

  static TextStyle getBoldStyle({required double fontSize, Color fontColor = Colors.black}) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: fontColor,
        fontWeight: FontWeight.w700,
      );

  static TextStyle getLightStyle({required double fontSize, Color fontColor = Colors.black}) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: fontColor,
        fontWeight: FontWeight.w300,
      );

  static TextStyle getMediumStyle({required double fontSize, Color fontColor = Colors.black}) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: fontColor,
        fontWeight: FontWeight.w500,
      );

  static TextStyle getRegularStyle({required double fontSize, Color fontColor = Colors.black}) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: fontColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle getSemiBoldStyle({required double fontSize, Color fontColor = Colors.black}) => TextStyle(
        fontSize: fontSize,
        fontFamily: 'Poppins',
        color: fontColor,
        fontWeight: FontWeight.w600,
      );

  static Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return Colors.transparent;
    }
    return AppColors.primary;
  }

  static Color getTextColor(Set<WidgetStateProperty> states) {
    if (states.contains(WidgetState.hovered)) {
      return AppColors.primary;
    }
    return Colors.transparent;
  }

  static ButtonStyle filledButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(AppColors.primary),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(5),
    textStyle: WidgetStatePropertyAll(AppStyles.getSemiBoldStyle(fontSize: 17)),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
  );

  static ButtonStyle outlineButton = ButtonStyle(
    shape: WidgetStateProperty.all(RoundedRectangleBorder(side: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10))),
    padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    foregroundColor: WidgetStateProperty.all(Colors.grey),
    elevation: WidgetStateProperty.all(5),
  );
}

class ScaleSize {
  static double textScaler(BuildContext context, {double maxTextScaleFactor = 2}) {
    final double width = MediaQuery.of(context).size.width;
    final double val = (width / 500) * maxTextScaleFactor;
    return max(2, min(val, maxTextScaleFactor));
  }
}
