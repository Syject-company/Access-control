import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class EventSearchItem extends StatelessWidget {
  const EventSearchItem({
    Key? key,
    required this.locationName,
    required this.eventDate,
    required this.projectPermissionAccess,
    required this.cameraId,
    required this.locationAddress,
    required this.personFirstName,
    required this.personLastName,
    required this.personDetails,
  }) : super(key: key);

  final String locationName;
  final String eventDate;
  final String projectPermissionAccess;
  final String cameraId;
  final String locationAddress;
  final String? personFirstName;
  final String? personLastName;
  final String? personDetails;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: personFirstName != null
            ? Dimensions.eventSearchItemMinHeight.h
            : Dimensions.eventSearchItemMinHeightNoPerson.h,
        minWidth: Dimensions.eventSearchItemMinWidth.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                IconsRes.resultItemCircle,
                height: Dimensions.resultIconIcon.w,
                width: Dimensions.resultIconIcon.w,
                matchTextDirection: true,
              ),
              SizedBox(
                width: Dimensions.margin8.w,
              ),
              TextView(
                title: locationName,
                weight: FontWeight.w400,
                size: TextSizes.sp15.sp,
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.margin5.h,
          ),
          TextView(
            title: eventDate,
            weight: FontWeight.w600,
            size: TextSizes.sp13.sp,
          ),
          SizedBox(
            height: Dimensions.margin12.h,
          ),
          TextView(
            title: projectPermissionAccess,
            weight: FontWeight.w400,
            size: TextSizes.sp13.sp,
            color: ColorsRes.darkGreyText,
          ),
          SizedBox(
            height: Dimensions.margin5.h,
          ),
          Row(
            children: <Widget>[
              TextView(
                title: StringsRes.camera,
                weight: FontWeight.w400,
                size: TextSizes.sp13.sp,
              ),
              TextView(
                title: cameraId,
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
              title: locationAddress,
              weight: FontWeight.w400,
              size: TextSizes.sp13.sp,
              color: ColorsRes.darkGreyText,
              lines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Visibility(
            visible: personFirstName != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Dimensions.margin8.h,
                ),
                TextView(
                  title: '$personFirstName ${personLastName ?? ''}',
                  weight: FontWeight.w700,
                  size: TextSizes.sp13.sp,
                ),
                SizedBox(
                  height: Dimensions.margin5.h,
                ),
                TextView(
                  title: personDetails ?? '',
                  weight: FontWeight.w400,
                  size: TextSizes.sp13.sp,
                  color: ColorsRes.darkGreyText,
                ),
              ],
            ),
          ),
          Container(
            width: Dimensions.dividerWidth.w,
            margin: EdgeInsets.only(
              top: Dimensions.margin8.h,
              bottom: Dimensions.margin13.h,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorsRes.divider, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
