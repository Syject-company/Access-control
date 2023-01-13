import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/lined_button.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class DialogConfirmView extends StatelessWidget {
  const DialogConfirmView({
    Key? key,
    required this.title,
    required this.content,
    required this.topButtonText,
    this.belowButtonText = StringsRes.cancel,
    required this.topOnTap,
    required this.controller,
  }) : super(key: key);

  final String title;
  final String content;
  final String topButtonText;
  final String belowButtonText;
  final VoidCallback topOnTap;
  final RoundedLoadingButtonController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _title,
      content: _content,
      contentPadding: EdgeInsets.all(Dimensions.padding16.w),
      actionsPadding: EdgeInsets.all(Dimensions.padding16.w),
      actions: <Widget>[
        SolidButton(
          label: topButtonText,
          onTap: topOnTap,
          controller: controller,
          isAnimateOnTap: false,
        ),
        SizedBox(
          height: Dimensions.margin16.h,
        ),
        LinedButton(
          label: belowButtonText,
          onTap: () => getIt<Navigation>().pop(),
        ),
        SizedBox(
          height: Dimensions.margin16.h,
        ),
      ],
    );
  }

  Widget get _title => TextView(
        title: title,
        size: TextSizes.sp19.sp,
        weight: FontWeight.w700,
        align: TextAlign.center,
        color: ColorsRes.primaryText,
      );

  Widget get _content => TextView(
        title: content,
        size: TextSizes.sp14.sp,
        weight: FontWeight.w400,
        align: TextAlign.center,
        color: ColorsRes.primaryText,
      );
}
