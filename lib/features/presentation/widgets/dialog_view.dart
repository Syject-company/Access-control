import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';
import 'package:safe_access/features/presentation/widgets/title_button.dart';

class DialogView extends StatelessWidget {
  const DialogView({
    Key? key,
    required this.title,
    required this.content,
    this.leftButtonText,
    required this.rightButtonText,
    this.leftOnTap,
    required this.rightOnTap,
  }) : super(key: key);

  final String title;
  final String content;
  final String? leftButtonText;
  final String rightButtonText;
  final VoidCallback? leftOnTap;
  final VoidCallback rightOnTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _title,
      content: _content,
      contentPadding: const EdgeInsets.all(Dimensions.padding50),
      actions: <Widget>[
        Row(
          mainAxisAlignment: leftButtonText != null
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: leftButtonText != null,
              child: Center(
                child: TitleButton(
                  title: leftButtonText ?? '',
                  color: ColorsRes.subText,
                  onTap: leftOnTap ?? () {},
                ),
              ),
            ),
            Center(
              child: TitleButton(
                title: rightButtonText,
                color: ColorsRes.primaryText,
                onTap: rightOnTap,
              ),
            ),
          ],
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
        size: TextSizes.sp16.sp,
        weight: FontWeight.w400,
        align: TextAlign.center,
        color: ColorsRes.primaryText,
      );
}
