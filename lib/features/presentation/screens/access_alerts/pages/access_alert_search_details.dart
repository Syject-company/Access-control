import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_bloc.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_event.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_state.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/action_bar.dart';
import 'package:safe_access/features/presentation/widgets/floating_button.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/solid_button.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class AccessAlertSearchDetails extends StatefulWidget {
  const AccessAlertSearchDetails({
    Key? key,
    required this.model,
    required this.isHandled,
    required this.image,
  }) : super(key: key);

  final AccessAlertResponseModel model;
  final bool isHandled;
  final String image;

  @override
  AccessAlertSearchDetailsState createState() =>
      AccessAlertSearchDetailsState();
}

class AccessAlertSearchDetailsState extends State<AccessAlertSearchDetails> {
  late String _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccessAlertsBloc, AccessAlertsState>(
      listener: (BuildContext context, AccessAlertsState state) {
        if (state is TheAlertImageReloaded) {
          _image = state.imageUrl;
        }
      },
      builder: (BuildContext context, AccessAlertsState state) {
        return SafeArea(
          child: Scaffold(
            appBar: ActionBar(
              title: StringsRes.accessAlertDetails,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_image.isNotEmpty && _image.startsWith('http'))
                  CachedNetworkImage(
                    imageUrl: _image,
                    height: Dimensions.accessDetailsImage.h,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, String url) =>
                        const ProgIndicator(),
                    errorWidget:
                        (BuildContext context, String url, dynamic error) {
                      context
                          .read<AccessAlertsBloc>()
                          .add(ReloadTheAlertImage(imageUrl: _image));
                      return Image.asset(
                        IconsRes.noImage,
                        height: Dimensions.accessDetailsImage.h,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                else
                  Image.asset(
                    IconsRes.noImage,
                    height: Dimensions.accessDetailsImage.h,
                    fit: BoxFit.cover,
                  ),
                SizedBox(
                  height: Dimensions.margin16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.padding24.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextView(
                        title: ItemsData.classifications
                            .nameClassification(widget.model.classificationId),
                        weight: FontWeight.w600,
                        size: TextSizes.sp19.sp,
                      ),
                      SizedBox(
                        height: Dimensions.margin8.h,
                      ),
                      TextView(
                        title: widget.model.createDate != null
                            ? widget.model.createDate!.formattedDate
                            : 'N/A',
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
                                '${widget.model.alertDetails?.hardware?.identifier} ${widget.model.alertDetails?.hardware?.serialNumber}',
                            weight: FontWeight.w700,
                            size: TextSizes.sp13.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.margin5.h,
                      ),
                      TextView(
                        title: widget.model.alertDetails.address,
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        color: ColorsRes.darkGreyText,
                      ),
                      Visibility(
                        visible: widget.model.person?.firstName != null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: Dimensions.margin16.h,
                            ),
                            TextView(
                              title:
                                  '${widget.model.person?.firstName ?? ''} ${widget.model.person?.surname ?? ''}',
                              weight: FontWeight.w700,
                              size: TextSizes.sp13.sp,
                            ),
                            SizedBox(
                              height: Dimensions.margin5.h,
                            ),
                            TextView(
                              title:
                                  '${widget.model.person?.identificationNumber ?? ''}, ${widget.model.personsProjects?.position?.name ?? ''}, ${widget.model.personsProjects?.employer?.name ?? ''}',
                              weight: FontWeight.w400,
                              size: TextSizes.sp13.sp,
                              color: ColorsRes.secondaryText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SolidButton(
                  label: StringsRes.handleAlert,
                  onTap: () => context.read<AccessAlertsBloc>().add(
                      HandleAlertSearch(
                          id: widget.model.id ?? 0,
                          alertType: widget.model.alertType ?? 'unauthorized',
                          model: widget.model)),
                  isAnimateOnTap: false,
                  isClickable: !widget.isHandled &&
                      getIt<UserFuncPermission>().isCanHandleAccessAlerts,
                  controller: RoundedLoadingButtonController(),
                ),
                SizedBox(
                  height: Dimensions.margin24.h,
                ),
              ],
            ),
            floatingActionButton: const FloatingButton(
              bottomMargin: Dimensions.margin104,
            ),
          ),
        );
      },
    );
  }
}
