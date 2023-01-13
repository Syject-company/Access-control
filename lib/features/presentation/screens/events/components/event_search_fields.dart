import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/events_search_data.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/date_range_calendar.dart';
import 'package:safe_access/features/presentation/widgets/dropdown_field.dart';
import 'package:safe_access/features/presentation/widgets/input_text_field.dart';
import 'package:safe_access/features/presentation/widgets/multi_selectable_field.dart';
import 'package:safe_access/features/presentation/widgets/switch_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class EventsSearchFields extends StatelessWidget {
  const EventsSearchFields({
    Key? key,
    required this.isShownFirstAppearance,
    required this.onToggleFirstAppearances,
    required this.timeRange,
    required this.timeRangeText,
    required this.passportIdController,
    required this.isShownActiveProjects,
    required this.onToggleActiveProjects,
    required this.projectItems,
    required this.lastProject,
    required this.onChangedProjects,
    required this.projectsFieldKey,
    required this.employers,
    required this.selectedEmployers,
    required this.positions,
    required this.selectedPositions,
    required this.classifications,
    required this.selectedClassifications,
    required this.isErrorNeedShow,
    required this.onChanged,
  }) : super(key: key);

  final bool isShownFirstAppearance;
  final Function(bool value) onToggleFirstAppearances;
  final Function(DateTimeRange range) timeRange;
  final String? timeRangeText;
  final TextEditingController passportIdController;
  final bool isShownActiveProjects;
  final Function(bool value) onToggleActiveProjects;
  final List<String> projectItems;
  final String? lastProject;
  final Function(String? value) onChangedProjects;
  final GlobalKey<FormFieldState<String>> projectsFieldKey;
  final List<String> employers;
  final Function(List<String> items) selectedEmployers;
  final List<String> positions;
  final Function(List<String> items) selectedPositions;
  final List<String> classifications;
  final Function(List<String> items) selectedClassifications;
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
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextView(
                title: StringsRes.firstAppearance,
                weight: FontWeight.w400,
                size: TextSizes.sp15.sp,
              ),
              SwitchButton(
                isOn: isShownFirstAppearance,
                onToggle: onToggleFirstAppearances,
              ),
            ],
          ),
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
          SizedBox(
            height: Dimensions.margin8.h,
          ),
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
            lastProjectName: lastProject,
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
          MultiSelectableField(
            title: StringsRes.employer,
            label: StringsRes.all,
            items: employers,
            selectedItems: getIt<EventsSearchData>().selectedEmployers,
            onSelectedResults: selectedEmployers,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          MultiSelectableField(
            title: StringsRes.position,
            label: StringsRes.all,
            items: positions,
            selectedItems: getIt<EventsSearchData>().selectedPositions,
            onSelectedResults: selectedPositions,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          MultiSelectableField(
            title: StringsRes.classification,
            label: StringsRes.all,
            items: classifications,
            selectedItems: getIt<EventsSearchData>().selectedClassifications,
            onSelectedResults: selectedClassifications,
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
