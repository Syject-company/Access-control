import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_bloc.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_event.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/registration/bloc/registration_state.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/notification_block.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class RegistrationExistsProject extends StatefulWidget {
  const RegistrationExistsProject({
    Key? key,
    required this.selectedProject,
    required this.workerPhoto,
    required this.approvedAccessDate,
    required this.passportID,
  }) : super(key: key);

  final String? workerPhoto;
  final String passportID;
  final String selectedProject;
  final String approvedAccessDate;

  @override
  RegistrationExistsProjectState createState() =>
      RegistrationExistsProjectState();
}

class RegistrationExistsProjectState extends State<RegistrationExistsProject> {
  bool _isNotifyShown = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (BuildContext context, RegistrationState state) {
        if (state is NotifyHidden) {
          _isNotifyShown = false;
        }
      },
      builder: (BuildContext context, RegistrationState state) {
        return SafeArea(
          child: Scaffold(
            appBar: ActionBar(
              title: StringsRes.registerWorker,
            ),
            body: Padding(
              padding: EdgeInsets.all(Dimensions.padding24.w),
              child: Stack(
                children: <Widget>[
                  Column(
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
                        height: Dimensions.margin58.h,
                      ),
                      Center(
                        child: SizedBox(
                          width: Dimensions.workerFoundByPhoto.w,
                          height: Dimensions.workerFoundByPhoto.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                Dimensions.workerFoundByPhoto.w),
                            child: widget.workerPhoto != null &&
                                    widget.workerPhoto!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: widget.workerPhoto ?? '',
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (BuildContext context, String url) =>
                                            const ProgIndicator(),
                                    errorWidget: (BuildContext context,
                                            String url, dynamic error) =>
                                        Container(
                                      width: Dimensions.accessImage.w,
                                      height: Dimensions.accessImage.w,
                                      color: ColorsRes.imageBack,
                                      child: Image.asset(
                                        IconsRes.noPhoto,
                                        height: Dimensions
                                            .workerNavButtonFirstIcon.h,
                                        width: Dimensions
                                            .workerNavButtonFirstIcon.w,
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
                                      height:
                                          Dimensions.workerNavButtonFirstIcon.h,
                                      width:
                                          Dimensions.workerNavButtonFirstIcon.w,
                                      matchTextDirection: true,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.margin8.h,
                      ),
                      TextView(
                        title: widget.passportID,
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        height: Dimensions.margin32.h,
                      ),
                      TextView(
                        title: widget.selectedProject,
                        weight: FontWeight.w700,
                        size: TextSizes.sp16.sp,
                        align: TextAlign.center,
                      ),
                      SizedBox(
                        height: Dimensions.margin3.h,
                      ),
                      TextView(
                        title:
                            '${StringsRes.approvedAccess.tr()}  ${widget.approvedAccessDate.tr()}',
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        align: TextAlign.center,
                        color: ColorsRes.darkGreyText,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Visibility(
                      visible: _isNotifyShown,
                      child: NotificationBlock(
                        msg: StringsRes.existsOnProject,
                        onTap: () => context
                            .read<RegistrationBloc>()
                            .add(const HideNotify()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
