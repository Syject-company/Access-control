import 'package:flutter/material.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/presentation/screens/workers/components/worker_search_item.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';
import 'package:safe_access/features/presentation/utils/no_glow_scroll_behavior.dart';
import 'package:safe_access/features/presentation/widgets/search_no_results.dart';

class WorkerSearchItemList extends StatelessWidget {
  const WorkerSearchItemList({
    Key? key,
    required this.list,
    required this.onItemTap,
  }) : super(key: key);

  final List<SearchWorkersResponseModel> list;
  final Function(int index) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => onItemTap(index),
                  splashColor: Colors.grey[200],
                  highlightColor: Colors.transparent,
                  child: WorkerSearchItem(
                    name:
                        '${list[index].firstName ?? ''} ${list[index].surname ?? ''}',
                    accessPermission: ItemsData.classifications
                        .nameClassification(list[index].classification?.id),
                    image: list[index].photoUrl,
                    lastEntrance: list[index].lastEntrance,
                  ),
                );
              },
            )
          : const SearchNoResults(),
    );
  }
}
