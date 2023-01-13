import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.hint,
    this.enable = true,
    required this.inputType,
    required this.pattern,
    required this.textController,
    required this.onChanged,
    this.isErrorNeedShow = false,
    this.maxLength = 15,
    this.isPassportAndId = true,
  }) : super(key: key);

  final String hint;
  final bool enable;
  final TextInputType inputType;
  final Pattern pattern;
  final TextEditingController textController;
  final Function(String value, bool isReachLimit) onChanged;
  final bool isErrorNeedShow;
  final int maxLength;
  final bool isPassportAndId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: Dimensions.buttonHeight50.h,
          child: TextField(
            controller: textController,
            keyboardType: inputType,
            onChanged: (String value) {
              //Note: to the limit error only after input the maxLength
              onChanged(value, textController.text.length == (maxLength + 1));
              if (textController.text.length == (maxLength + 1)) {
                textController.text =
                    textController.text.substring(0, maxLength);
                textController.selection =
                    TextSelection.fromPosition(TextPosition(offset: maxLength));
              }
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(pattern),
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: TextSizes.sp14.sp,
            ),
            enabled: enable,
            maxLength: maxLength + 1,
            decoration: InputDecoration(
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              disabledBorder: borderStyle,
              filled: true,
              fillColor: enable ? Colors.white : ColorsRes.disabledBack,
              counterText: '',
              contentPadding: EdgeInsets.all(
                Dimensions.padding16.h,
              ),
              hintText: hint.tr(),
              hintStyle: TextStyle(
                color: ColorsRes.subText,
                fontWeight: FontWeight.w400,
                fontSize: TextSizes.sp14.sp,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isErrorNeedShow,
          child: TextView(
            title: textController.text.length == 15
                ? isPassportAndId
                    ? StringsRes.lengthIDPassportError
                    : StringsRes.lengthPassportError
                : StringsRes.lengthIDError,
            weight: FontWeight.w400,
            size: TextSizes.sp13.sp,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder get borderStyle => OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsRes.borderDropMenu,
          width: Dimensions.menuBorder.w,
        ),
      );
}
