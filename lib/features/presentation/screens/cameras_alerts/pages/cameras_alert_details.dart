import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_bloc.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/bloc/cameras_event.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show AlertAddressInfo, CamerasStatusTitle, DateTimeExtension;
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class CamerasAlertDetails extends StatelessWidget {
  const CamerasAlertDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

  final CameraAlertResponseModel model;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ActionBar(
          title: StringsRes.cameraAlertDetails,
        ),
        body: Padding(
          padding: EdgeInsets.all(Dimensions.padding24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextView(
                title: ItemsData.cameraStatus.nameCameraStatus(model.status),
                weight: FontWeight.w600,
                size: TextSizes.sp19.sp,
              ),
              SizedBox(
                height: Dimensions.margin8.h,
              ),
              TextView(
                title: model.createDate != null
                    ? model.createDate!.formattedDate
                    : DateTime.now().formattedDate,
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
                color: ColorsRes.darkGreyText,
              ),
              Visibility(
                visible:
                    ItemsData.cameraStatus.nameCameraStatusDesc(model.status) != '',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: Dimensions.margin8.h,
                    ),
                    TextView(
                      title: ItemsData.cameraStatus
                          .nameCameraStatusDesc(model.status),
                      weight: FontWeight.w400,
                      size: TextSizes.sp13.sp,
                      color: ColorsRes.darkGreyText,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.margin16.h,
              ),
              Row(
                children: <Widget>[
                  TextView(
                    title: StringsRes.camera,
                    weight: FontWeight.w400,
                    size: TextSizes.sp13.sp,
                  ),
                  TextView(
                    title:
                        '${model.cameraId} ${model.alertDetails?.hardware?.serialNumber}',
                    weight: FontWeight.w700,
                    size: TextSizes.sp13.sp,
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.margin5.h,
              ),
              TextView(
                title: model.alertDetails.address,
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
                color: ColorsRes.darkGreyText,
              ),
              const Spacer(),
              _handlerAlert(onTap: () {
                context.read<CamerasBloc>().add(HandleAlert(id: model.id ?? 0));
              }),
            ],
          ),
        ),
        floatingActionButton: const FloatingButton(
          bottomMargin: Dimensions.margin104,
        ),
      ),
    );
  }

  Widget _handlerAlert({required VoidCallback onTap}) {
    return SolidButton(
      label: StringsRes.handleAlert,
      onTap: onTap,
      isAnimateOnTap: false,
      isClickable: getIt<UserFuncPermission>().isCanHandleHardwareAlerts,
      controller: RoundedLoadingButtonController(),
    );
  }
}
