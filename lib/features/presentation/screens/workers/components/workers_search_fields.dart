import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/worker_search_data.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/dropdown_field.dart';
import 'package:safe_access/features/presentation/widgets/input_text_field.dart';
import 'package:safe_access/features/presentation/widgets/multi_selectable_field.dart';
import 'package:safe_access/features/presentation/widgets/switch_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkersSearchFields extends StatelessWidget {
  const WorkersSearchFields({
    Key? key,
    required this.isShownActiveProjects,
    required this.onToggleActiveProjects,
    required this.projects,
    required this.onChangedProjects,
    required this.projectsFieldKey,
    required this.textController,
    required this.positions,
    required this.selectedPositions,
    required this.classifications,
    required this.selectedClassifications,
    required this.employers,
    required this.selectedEmployers,
    required this.isErrorNeedShow,
    required this.onChanged,
    required this.lastProject,
  }) : super(key: key);

  final bool isShownActiveProjects;
  final Function(bool value) onToggleActiveProjects;
  final List<String> projects;
  final Function(String? value) onChangedProjects;
  final GlobalKey<FormFieldState<String>> projectsFieldKey;
  final String? lastProject;

  final TextEditingController textController;

  final List<String> positions;
  final Function(List<String> items) selectedPositions;
  final List<String> classifications;
  final Function(List<String> items) selectedClassifications;
  final List<String> employers;
  final Function(List<String> items) selectedEmployers;
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
            items: projects,
            hint: StringsRes.selectProject,
            onChanged: onChangedProjects,
            isInActiveAndActiveProjects: true,
            lastProjectName: lastProject,
          ),
          SizedBox(
            height: Dimensions.margin5.h,
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
          TextView(
            title: StringsRes.enterIDPassport,
            weight: FontWeight.w400,
            size: TextSizes.sp16.sp,
          ),
          SizedBox(
            height: Dimensions.margin10.h,
          ),
          InputTextField(
            textController: textController,
            hint: StringsRes.iDAndPassport,
            inputType: TextInputType.text,
            pattern: RegExp(r'[^"]'),
            onChanged: onChanged,
            isErrorNeedShow: isErrorNeedShow,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          MultiSelectableField(
            title: StringsRes.position,
            label: StringsRes.all,
            items: positions,
            selectedItems: getIt<WorkerSearchData>().selectedPositions,
            onSelectedResults: selectedPositions,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          MultiSelectableField(
            title: StringsRes.classification,
            label: StringsRes.all,
            items: classifications,
            selectedItems: getIt<WorkerSearchData>().selectedClassifications,
            onSelectedResults: selectedClassifications,
          ),
          SizedBox(
            height: Dimensions.margin8.h,
          ),
          MultiSelectableField(
            title: StringsRes.employer,
            label: StringsRes.all,
            items: employers,
            selectedItems: getIt<WorkerSearchData>().selectedEmployers,
            onSelectedResults: selectedEmployers,
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
