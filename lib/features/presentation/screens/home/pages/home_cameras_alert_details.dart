import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_bloc.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_event.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show DateTimeExtension, AlertAddressInfo;
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class HomeCamerasAlertDetails extends StatelessWidget {
  const HomeCamerasAlertDetails({
    Key? key,
    required this.model,
    required this.isCanHandle,
  }) : super(key: key);

  final CameraAlertResponseModel model;
  final bool isCanHandle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (!context.read<HomeBloc>().isClosed) {
          context
              .read<HomeBloc>()
              .add(const ShowFCMDataLoading(isShown: false));
        }
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
                    title: model.statusDes ?? 'N/A',
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
                    context
                        .read<HomeBloc>()
                        .add(HandleHardwareAlert(id: model.id ?? 0));
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _handlerAlert({required VoidCallback onTap}) {
    return SolidButton(
      label: StringsRes.handleAlert,
      onTap: onTap,
      isAnimateOnTap: false,
      isClickable: isCanHandle,
      controller: RoundedLoadingButtonController(),
    );
  }
}
