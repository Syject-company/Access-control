import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/input_text_field.dart';
import 'package:safe_access/features/presentation/widgets/radio_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class InputTextPassportId extends StatelessWidget {
  const InputTextPassportId({
    Key? key,
    required this.isPassportChecked,
    required this.onTapPassport,
    required this.passportController,
    required this.isIDChecked,
    required this.onTapID,
    required this.iDController,
    required this.onChanged,
    required this.isErrorNeedShow,
    required this.title,
  }) : super(key: key);

  final bool isPassportChecked;
  final VoidCallback onTapPassport;
  final TextEditingController passportController;
  final bool isIDChecked;
  final VoidCallback onTapID;
  final TextEditingController iDController;
  final Function(String value, bool isReachLimit) onChanged;
  final bool isErrorNeedShow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextView(
          title: title,
          weight: FontWeight.w400,
          size: TextSizes.sp16.sp,
        ),
        SizedBox(
          height: Dimensions.margin10.h,
        ),
        Stack(
          children: <Widget>[
            InputTextField(
              textController: iDController,
              hint: StringsRes.idCard,
              enable: isIDChecked,
              inputType: TextInputType.number,
              pattern: RegExp(r'[0-9]'),
              onChanged: onChanged,
              isPassportAndId: false,
              maxLength: 9,
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: Dimensions.padding6.w,
              top: Dimensions.padding6.h,
              bottom: Dimensions.padding6.h,
              child: RadioButton(
                isChecked: isIDChecked,
                onPressed: onTapID,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.margin8.h,
        ),
        Stack(
          children: <Widget>[
            InputTextField(
              textController: passportController,
              hint: StringsRes.passport,
              enable: isPassportChecked,
              inputType: TextInputType.name,
              pattern: RegExp(r'[^"]'),
              onChanged: onChanged,
              maxLength: 15,
              isPassportAndId: false,
              isErrorNeedShow: isErrorNeedShow,
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: Dimensions.padding6.w,
              top: Dimensions.padding6.h,
              bottom: isErrorNeedShow
                  ? Dimensions.padding25.h
                  : Dimensions.padding6.h,
              child: RadioButton(
                isChecked: isPassportChecked,
                onPressed: onTapPassport,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
