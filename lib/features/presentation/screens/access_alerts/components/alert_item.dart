import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_bloc.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_event.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/bloc/access_alerts_state.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class AlertItem extends StatefulWidget {
  const AlertItem({
    Key? key,
    required this.status,
    required this.time,
    required this.cameraId,
    required this.location,
    required this.image,
    required this.personFirstName,
    required this.personLastName,
    required this.personDetails,
  }) : super(key: key);

  final String status;
  final String time;
  final String cameraId;
  final String location;
  final String? image;
  final String? personFirstName;
  final String? personLastName;
  final String? personDetails;

  @override
  AlertItemState createState() => AlertItemState();
}

class AlertItemState extends State<AlertItem> {
  String? _image;

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
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Dimensions.accessItemMinHeight.h,
            minWidth: Dimensions.accessItemMinWidth.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: Dimensions.accessImage.w,
                  height: Dimensions.accessImage.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: _image != null &&
                            _image!.isNotEmpty &&
                            _image!.startsWith('http')
                        ? CachedNetworkImage(
                            imageUrl: _image ?? '',
                            fit: BoxFit.cover,
                            maxHeightDiskCache: Dimensions.maxImageSize,
                            maxWidthDiskCache: Dimensions.maxImageSize,
                            errorWidget: (BuildContext cont, String url,
                                dynamic error) {
                              context
                                  .read<AccessAlertsBloc>()
                                  .add(ReloadTheAlertImage(imageUrl: _image!));
                              return Container(
                                width: Dimensions.accessImage.w,
                                height: Dimensions.accessImage.w,
                                color: ColorsRes.imageBack,
                                child: Image.network(
                                  url,
                                  height: Dimensions.workerNavButtonFirstIcon.h,
                                  width: Dimensions.workerNavButtonFirstIcon.w,
                                  matchTextDirection: true,
                                ),
                              );
                            },
                            placeholder: (BuildContext context, String url) =>
                                const ProgIndicator(),
                          )
                        : Image.asset(
                            IconsRes.noImage,
                            width: Dimensions.accessImage.w,
                            height: Dimensions.accessImage.w,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.margin13.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextView(
                    title: widget.status,
                    weight: FontWeight.w400,
                    size: TextSizes.sp16.sp,
                  ),
                  SizedBox(
                    height: Dimensions.margin5.h,
                  ),
                  TextView(
                    title: widget.time,
                    weight: FontWeight.w400,
                    size: TextSizes.sp13.sp,
                    color: ColorsRes.darkGreyText,
                  ),
                  SizedBox(
                    height: Dimensions.margin10.h,
                  ),
                  Row(
                    children: <Widget>[
                      TextView(
                        title: StringsRes.camera,
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                      ),
                      TextView(
                        title: widget.cameraId,
                        weight: FontWeight.w700,
                        size: TextSizes.sp13.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.margin5.h,
                  ),
                  SizedBox(
                    width: Dimensions.accessItemTextMinWidth.w,
                    child: TextView(
                      title: widget.location,
                      weight: FontWeight.w400,
                      size: TextSizes.sp13.sp,
                      color: ColorsRes.darkGreyText,
                      lines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Visibility(
                    visible: widget.personFirstName != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: Dimensions.margin10.h,
                        ),
                        TextView(
                          title:
                              '${widget.personFirstName} ${widget.personLastName ?? ''}',
                          weight: FontWeight.w700,
                          size: TextSizes.sp13.sp,
                        ),
                        SizedBox(
                          height: Dimensions.margin5.h,
                        ),
                        TextView(
                          title: widget.personDetails ?? '',
                          weight: FontWeight.w400,
                          size: TextSizes.sp13.sp,
                          color: ColorsRes.darkGreyText,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Dimensions.dividerWidth.w,
                    margin:
                        EdgeInsets.symmetric(vertical: Dimensions.margin16.h),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: ColorsRes.divider, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
