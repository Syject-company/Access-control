import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/components/alert_item.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/no_glow_scroll_behavior.dart';
import 'package:safe_access/features/presentation/widgets/search_no_results.dart';

class AlertItemList extends StatelessWidget {
  const AlertItemList({
    Key? key,
    required this.list,
    required this.onItemTap,
  }) : super(key: key);

  final List<AccessAlertResponseModel> list;
  final Function(AccessAlertResponseModel model) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(
                bottom: Dimensions.padding16.h,
              ),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => onItemTap(list[index]),
                  splashColor: Colors.grey[200],
                  highlightColor: Colors.transparent,
                  child: AlertItem(
                    status: ItemsData.classifications
                        .nameClassification(list[index].classificationId),
                    time: list[index].createDate != null
                        ? list[index].createDate!.formattedDate
                        : 'N/A',
                    cameraId:
                        '${list[index].alertDetails?.hardware?.identifier} ${list[index].alertDetails?.hardware?.serialNumber}',
                    location: list[index].alertDetails.address,
                    personFirstName: list[index].person?.firstName,
                    personLastName: list[index].person?.surname,
                    personDetails:
                        '${list[index].person?.identificationNumber}, ${list[index].personsProjects?.position?.name}, ${list[index].personsProjects?.employer?.name}',
                    image: list[index].person?.image?.imgUrl ??
                        list[index].image?.imgUrl,
                  ),
                );
              },
            )
          : const SearchNoResults(),
    );
  }
}
