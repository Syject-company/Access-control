import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/components/camera_alert_item.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show AlertAddressInfo, CamerasStatusTitle, DateTimeExtension;
import 'package:safe_access/features/presentation/utils/no_glow_scroll_behavior.dart';
import 'package:safe_access/features/presentation/widgets/text_view.dart';

class CameraAlertItemList extends StatelessWidget {
  const CameraAlertItemList({
    Key? key,
    required this.list,
    required this.onItemTap,
  }) : super(key: key);

  final List<CameraAlertResponseModel> list;
  final Function(CameraAlertResponseModel model) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: Dimensions.padding16.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => onItemTap(list[index]),
                  splashColor: Colors.grey[200],
                  highlightColor: Colors.transparent,
                  child: CameraAlertItem(
                    alertCameraId:
                        '${list[index].cameraId} ${list[index].alertDetails?.hardware?.serialNumber}',
                    alertLocation: list[index].alertDetails.address,
                    alertStatusTitle: ItemsData.cameraStatus
                        .nameCameraStatus(list[index].status),
                    alertTime: list[index].createDate != null
                        ? list[index].createDate!.formattedDate
                        : 'N/A',
                  ),
                );
              },
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Center(
                  child: TextView(
                    title: StringsRes.noAlerts,
                    weight: FontWeight.w400,
                    size: TextSizes.sp13.sp,
                  ),
                ),
              ),
            ),
    );
  }
}
