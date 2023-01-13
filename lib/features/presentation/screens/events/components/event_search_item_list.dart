import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/screens/events/components/event_search_item.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/widgets/search_no_results.dart';

class EventSearchItemList extends StatelessWidget {
  const EventSearchItemList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<EventsSearchResponseModel> list;

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              bottom: Dimensions.padding16.h,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return EventSearchItem(
                locationName: list[index].alertDetails?.project?.name ?? '',
                eventDate: list[index].createDate != null
                    ? list[index].createDate!.formattedDate
                    : 'N/A',
                projectPermissionAccess:
                    '${ItemsData.classifications.nameClassification(list[index].classifications?.id)}, ${list[index].personsProjects?.employer?.name ?? ''} ',
                cameraId:
                    '${list[index].alertDetails?.hardware?.identifier} ${list[index].alertDetails?.hardware?.serialNumber}',
                locationAddress: list[index].alertDetails.address,
                personFirstName: list[index].person?.firstName,
                personLastName: list[index].person?.surname,
                personDetails:
                    '${list[index].person?.identificationNumber}, ${list[index].personsProjects?.position?.name}, ${list[index].personsProjects?.employer?.name}',
              );
            },
          )
        : const SearchNoResults();
  }
}
