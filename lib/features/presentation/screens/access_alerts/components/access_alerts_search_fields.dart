import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/access_alert_search_data.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/date_range_calendar.dart';
import 'package:safe_access/features/presentation/widgets/dropdown_field.dart';
import 'package:safe_access/features/presentation/widgets/input_text_field.dart';
import 'package:safe_access/features/presentation/widgets/multi_selectable_field.dart';
import 'package:safe_access/features/presentation/widgets/switch_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class AccessAlertsSearchFields extends StatelessWidget {
  const AccessAlertsSearchFields({
    Key? key,
    required this.isShownActiveProjects,
    required this.onToggleActiveProjects,
    required this.projectItems,
    required this.onChangedProjects,
    required this.projectsFieldKey,
    required this.statusItems,
    required this.onChangedStatus,
    required this.statusFieldKey,
    required this.classifications,
    required this.selectedClassifications,
    required this.passportIdController,
    required this.timeRange,
    required this.timeRangeText,
    required this.isErrorNeedShow,
    required this.onChanged,
  }) : super(key: key);

  final bool isShownActiveProjects;
  final Function(bool value) onToggleActiveProjects;
  final List<String> projectItems;
  final Function(String? value) onChangedProjects;
  final GlobalKey<FormFieldState<String>> projectsFieldKey;
  final List<String> statusItems;
  final Function(String? value) onChangedStatus;
  final GlobalKey<FormFieldState<String>> statusFieldKey;
  final List<String> classifications;
  final Function(List<String> items) selectedClassifications;
  final TextEditingController passportIdController;
  final Function(DateTimeRange range) timeRange;
  final String? timeRangeText;
  final bool isErrorNeedShow;
  final Function(String value, bool isReachLimit) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.padding24.w,
        vertical: Dimensions.padding16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _text(
            title: StringsRes.project,
          ),
          SizedBox(
            height: Dimensions.margin5.h,
          ),
          DropdownField(
            dropdownFieldKey: projectsFieldKey,
            items: projectItems,
            hint: StringsRes.selectProject,
            onChanged: onChangedProjects,
            isInActiveAndActiveProjects: true,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextView(
                title: StringsRes.activeProjects,
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
              ),
              SwitchButton(
                isOn: isShownActiveProjects,
                onToggle: onToggleActiveProjects,
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          DropdownField(
            title: StringsRes.status,
            dropdownFieldKey: statusFieldKey,
            items: statusItems,
            hint: StringsRes.notHandled,
            onChanged: onChangedStatus,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          MultiSelectableField(
              title: StringsRes.classification,
              label: StringsRes.all,
              items: classifications,
              selectedItems:
                  getIt<AccessAlertSearchData>().selectedClassifications,
              onSelectedResults: selectedClassifications),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          DateRangeCalendar(
            timeRange: timeRange,
            timeRangeText: timeRangeText,
            title: StringsRes.dateRangeRequired,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          TextView(
            title: StringsRes.enterIDPassport,
            weight: FontWeight.w400,
            size: TextSizes.sp16.sp,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          InputTextField(
            textController: passportIdController,
            hint: StringsRes.iDAndPassport,
            inputType: TextInputType.text,
            pattern: RegExp(r'[^"]'),
            isErrorNeedShow: isErrorNeedShow,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _text({required String title}) => TextView(
        title: title,
        weight: FontWeight.w400,
        size: TextSizes.sp16.sp,
      );
}
