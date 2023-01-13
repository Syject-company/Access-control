import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    Key? key,
    required this.items,
    this.title,
    required this.hint,
    required this.onChanged,
    required this.dropdownFieldKey,
    this.isInActiveAndActiveProjects = false,
    this.lastProjectName,
  }) : super(key: key);

  final List<String> items;
  final String? title;
  final String hint;
  final Function(String? value) onChanged;
  final bool isInActiveAndActiveProjects;
  final String? lastProjectName;

  //Note: to reset the value
  final GlobalKey<FormFieldState<String>> dropdownFieldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Visibility(
          visible: title != null,
          child: TextView(
            title: title ?? '',
            weight: FontWeight.w400,
            size: TextSizes.sp16.sp,
          ),
        ),
        SizedBox(
          height: Dimensions.margin8.h,
        ),
        SizedBox(
          height: Dimensions.buttonHeight50.h,
          child: DropdownButtonFormField<String>(
            key: dropdownFieldKey,
            value: lastProjectName,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(
                      value,
                      style: TextStyle(
                        fontFamily: StringsRes.fontFamily,
                        fontSize: TextSizes.sp13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.margin5.w,
                    ),
                    Visibility(
                      visible: isInActiveAndActiveProjects &&
                          !getIt<ProjectsData>().projects!.isActive(value),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            const TextSpan(text: '('),
                            TextSpan(
                              text: StringsRes.inactive.tr(),
                              style: TextStyle(
                                  fontFamily: StringsRes.fontFamily,
                                  fontSize: TextSizes.sp13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.redAccent),
                            ),
                            const TextSpan(text: ')'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            hint: TextView(
              title: hint,
              size: TextSizes.sp14.sp,
              weight: FontWeight.w400,
              color: ColorsRes.subText,
            ),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: TextSizes.sp14.sp,
            ),
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: Dimensions.toggleSize.h,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.padding12.w,
                vertical: Dimensions.padding15.h,
              ),
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
            ),
            onChanged: onChanged,
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
