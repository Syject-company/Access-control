import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';

class AppTheme {
  ThemeData get materialThemeData => ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorsRes.primary,
        scaffoldBackgroundColor: ColorsRes.backGround,
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(ColorsRes.secondPrimary),
          isAlwaysShown: true,
          crossAxisMargin: Dimensions.margin3,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorsRes.appBarBackground,
          centerTitle: true,
          elevation: 0.1,
          toolbarHeight: Dimensions.appBarHeight.h,
          titleTextStyle: TextStyle(
            color: ColorsRes.appBarTitle,
            fontFamily: StringsRes.fontFamily,
            fontSize: TextSizes.sp17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorsRes.accent,
        ),
        fontFamily: StringsRes.fontFamily,
      );
}
