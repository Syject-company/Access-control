import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_event.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show TextValue;
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

import 'bloc/registration_bloc.dart';

class RegistrationFoundByPhoto extends StatelessWidget {
  const RegistrationFoundByPhoto({
    Key? key,
    required this.selectedPassportID,
    required this.selectedProject,
    required this.personId,
    required this.projectId,
    required this.existsProject,
    required this.idType,
    required this.existsAccessDate,
    required this.existsPassportID,
    required this.existsPhoto,
    required this.existsWorkerPosition,
    required this.isFoundOnCurrentProject,
  }) : super(key: key);

  final int personId;
  final int projectId;
  final int idType;
  final bool isFoundOnCurrentProject;
  final String selectedProject;
  final String selectedPassportID;
  final String? existsPassportID;
  final String? existsPhoto;
  final String? existsWorkerPosition;
  final String? existsProject;
  final String? existsAccessDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ActionBar(
        title: StringsRes.registerWorker,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.padding24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextView(
              title: StringsRes.step2,
              weight: FontWeight.w400,
              size: TextSizes.sp16.sp,
              align: TextAlign.center,
              color: ColorsRes.steelBlueText,
            ),
            SizedBox(
              height: Dimensions.margin5.h,
            ),
            Image.asset(
              IconsRes.step2,
              matchTextDirection: true,
            ),
            SizedBox(
              height: Dimensions.margin24.h,
            ),
            TextView(
              title: StringsRes.workerFoundByPhoto,
              weight: FontWeight.w600,
              size: TextSizes.sp16.sp,
              align: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.margin10.h,
            ),
            TextView(
              title: isFoundOnCurrentProject
                  ? foundByPhotoCurrentProject(selectedPassportID, idType)
                  : foundByPhotoAddToProject(
                      selectedProject,
                      selectedPassportID,
                      context.locale == const Locale('he'),
                      idType),
              weight: FontWeight.w400,
              size: TextSizes.sp13.sp,
              align: TextAlign.center,
              color: ColorsRes.darkGreyText,
            ),
            SizedBox(
              height: Dimensions.margin43.h,
            ),
            Center(
              child: SizedBox(
                width: Dimensions.workerFoundByPhoto.w,
                height: Dimensions.workerFoundByPhoto.w,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.workerFoundByPhoto.w),
                  child: existsPhoto != null && existsPhoto!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: existsPhoto ?? '',
                          fit: BoxFit.cover,
                          placeholder: (BuildContext context, String url) =>
                              const ProgIndicator(),
                          errorWidget: (BuildContext context, String url,
                                  dynamic error) =>
                              Container(
                            width: Dimensions.accessImage.w,
                            height: Dimensions.accessImage.w,
                            color: ColorsRes.imageBack,
                            child: Image.asset(
                              IconsRes.noPhoto,
                              height: Dimensions.workerNavButtonFirstIcon.h,
                              width: Dimensions.workerNavButtonFirstIcon.w,
                              matchTextDirection: true,
                            ),
                          ),
                        )
                      : Container(
                          width: Dimensions.accessImage.w,
                          height: Dimensions.accessImage.w,
                          color: ColorsRes.imageBack,
                          child: Image.asset(
                            IconsRes.noPhoto,
                            height: Dimensions.workerNavButtonFirstIcon.h,
                            width: Dimensions.workerNavButtonFirstIcon.w,
                            matchTextDirection: true,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.margin8.h,
            ),
            Visibility(
              visible: isFoundOnCurrentProject,
              child: TextView(
                title: existsWorkerPosition ?? '',
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
                align: TextAlign.center,
                color: ColorsRes.darkGreyText,
              ),
            ),
            SizedBox(
              height: Dimensions.margin3.h,
            ),
            TextView(
              title: existsPassportID ?? '',
              weight: FontWeight.w400,
              size: TextSizes.sp13.sp,
              align: TextAlign.center,
            ),
            SizedBox(
              height: Dimensions.margin32.h,
            ),
            Visibility(
              visible: isFoundOnCurrentProject,
              child: TextView(
                title: existsProject ?? '',
                weight: FontWeight.w700,
                size: TextSizes.sp16.sp,
                align: TextAlign.center,
              ),
            ),
            SizedBox(
              height: Dimensions.margin3.h,
            ),
            Visibility(
              visible: isFoundOnCurrentProject,
              child: TextView(
                title:
                    '${StringsRes.approvedAccess.tr()} ${existsAccessDate?.tr()}',
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
                align: TextAlign.center,
                color: ColorsRes.darkGreyText,
              ),
            ),
            const Spacer(),
            _overrideIDPassport(onTap: () {
              context.read<RegistrationBloc>().add(
                    OverrideIDPassport(
                      idType: idType,
                      projectId: projectId,
                      idNumber: existsPassportID ?? '',
                      personId: personId,
                      selectedProject: selectedProject,
                      selectedIDPassport: selectedPassportID,
                      isFoundOnCurrentProject: isFoundOnCurrentProject,
                    ),
                  );
            }),
          ],
        ),
      ),
    ));
  }

  Widget _overrideIDPassport({required VoidCallback onTap}) => SolidButton(
        label:
            '${StringsRes.overrideIDPassport}${idType == 1 ? StringsRes.id.tr() : StringsRes.passport.tr()}',
        onTap: onTap,
        controller: RoundedLoadingButtonController(),
        isAnimateOnTap: false,
      );
}
