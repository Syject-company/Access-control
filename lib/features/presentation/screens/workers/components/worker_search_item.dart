import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/features/presentation/resources/colors_res.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/prog_indicator.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class WorkerSearchItem extends StatelessWidget {
  const WorkerSearchItem({
    Key? key,
    required this.name,
    required this.accessPermission,
    required this.image,
    required this.lastEntrance,
  }) : super(key: key);

  final String name;
  final String accessPermission;
  final String? image;
  final DateTime? lastEntrance;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: Dimensions.workerSearchItemMinHeight.h,
        minWidth: Dimensions.workerSearchItemMinWidth.w,
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
                child: image != null &&
                        image!.isNotEmpty &&
                        image!.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: image ?? '',
                        fit: BoxFit.cover,
                        maxHeightDiskCache: Dimensions.maxImageSize,
                        maxWidthDiskCache: Dimensions.maxImageSize,
                        repeat: ImageRepeat.repeat,
                        errorWidget:
                            (BuildContext context, String url, dynamic error) {
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
            width: Dimensions.margin13.w,
          ),
          SizedBox(
            width: Dimensions.workSearchItemWidth.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: TextView(
                        title: name,
                        weight: FontWeight.w400,
                        size: TextSizes.sp15.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextView(
                        title: lastEntrance != null
                            ? lastEntrance!.formattedDateWithOutTime
                            : '',
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.margin5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: TextView(
                        title: accessPermission,
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        color: ColorsRes.darkGreyText,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextView(
                        title: lastEntrance != null
                            ? lastEntrance!.formattedTime
                            : '',
                        weight: FontWeight.w400,
                        size: TextSizes.sp13.sp,
                        color: ColorsRes.secondaryText,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: Dimensions.dividerWidth.w,
                  margin: EdgeInsets.symmetric(vertical: Dimensions.margin16.h),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorsRes.divider, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
