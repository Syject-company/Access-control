import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/lined_icon_button.dart';
import 'package:safe_access/features/presentation/widgets/multi_selectable_dialog.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class MultiSelectableField extends StatefulWidget {
  const MultiSelectableField({
    Key? key,
    this.title,
    required this.label,
    required this.items,
    required this.selectedItems,
    required this.onSelectedResults,
  }) : super(key: key);

  final String? title;
  final String label;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectedResults;

  @override
  MultiSelectableFieldState createState() => MultiSelectableFieldState();
}

class MultiSelectableFieldState extends State<MultiSelectableField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Visibility(
          visible: widget.title != null,
          child: TextView(
            title: widget.title ?? '',
            weight: FontWeight.w400,
            size: TextSizes.sp16.sp,
          ),
        ),
        SizedBox(
          height: Dimensions.margin8.h,
        ),
        LinedIconButton(
          label: widget.selectedItems.fieldLabel(widget.items, widget.label),
          icon: IconsRes.arrowDown,
          iconColor: Colors.black,
          iconSize: Dimensions.buttonIcon20.h,
          width: double.maxFinite,
          height: Dimensions.buttonHeight50.h,
          borderSide: BorderSide(
            color: ColorsRes.borderDropMenu,
            width: Dimensions.menuBorder.w,
          ),
          borderRadius: Dimensions.padding5,
          padding: Dimensions.padding2,
          textStyle: TextStyle(
            fontSize: TextSizes.sp14.sp,
            color: widget.selectedItems.isNotEmpty
                ? ColorsRes.primaryText
                : ColorsRes.subText,
            fontWeight: FontWeight.w400,
          ),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (widget.items.isPermittedPerformAction) {
              _showMultiSelect();
            }
          },
        ),
      ],
    );
  }

  Future<void> _showMultiSelect() async {
    await showDialog<List<String>?>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectableDialog(
          items: widget.items,
          selectedItems: widget.selectedItems,
          buttonLabel: StringsRes.filter,
        );
      },
    ).then((List<String>? results) {
      if (results != null) {
        setState(() {
          widget.selectedItems.clear();
          widget.onSelectedResults(results);
        });
      }
    });
  }
}
