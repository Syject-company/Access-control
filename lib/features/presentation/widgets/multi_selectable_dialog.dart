import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/no_glow_scroll_behavior.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';
import 'package:safe_access/features/presentation/widgets/title_button.dart';

class MultiSelectableDialog extends StatefulWidget {
  const MultiSelectableDialog({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.buttonLabel,
  }) : super(key: key);

  final List<String> items;
  final List<String> selectedItems;
  final String buttonLabel;

  @override
  State<StatefulWidget> createState() => MultiSelectableDialogState();
}

class MultiSelectableDialogState extends State<MultiSelectableDialog> {
  List<String> selectedItems = <String>[];

  @override
  void initState() {
    super.initState();
    selectedItems.addAll(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(
        left: Dimensions.padding16.w,
        right: Dimensions.padding16.w,
        bottom: Dimensions.padding32.h,
        top: Dimensions.padding19.h,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Dimensions.padding16.w,
        vertical: Dimensions.padding19.h,
      ),
      title: Container(
        width: double.maxFinite,
        alignment: Alignment.centerRight,
        child: TitleButton(
          title: StringsRes.clearAll,
          color: ColorsRes.steelBlueText,
          onTap: _clearItems,
          titleSize: TextSizes.sp13,
          titleWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
      content: Scrollbar(
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: SingleChildScrollView(
            child: ListBody(
              children: widget.items
                  .map(
                    (String item) => CheckboxListTile(
                      value: selectedItems.contains(item),
                      title: TextView(
                        title: item,
                        weight: FontWeight.w400,
                        size: TextSizes.sp14.sp,
                      ),
                      activeColor: ColorsRes.filterButton,
                      side: const BorderSide(
                        width: 2.0,
                        color: ColorsRes.borderButton,
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? isChecked) => _itemSelected(
                          itemValue: item, isSelected: isChecked!),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        SolidButton(
          label: widget.buttonLabel,
          isAnimateOnTap: false,
          backColor: ColorsRes.filterButton,
          controller: RoundedLoadingButtonController(),
          onTap: () => getIt<Navigation>().pop(arguments: selectedItems),
        ),
      ],
    );
  }

  void _itemSelected({required String itemValue, required bool isSelected}) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void _clearItems() {
    setState(() {
      selectedItems.clear();
    });
  }
}
