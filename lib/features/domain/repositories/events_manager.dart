import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/data/entities/responses/events_search_main_response_model.dart';
import 'package:safe_access/features/domain/exceptions/exceptions.dart';

mixin EventsManager {
  Future<EventsSearchMainResponseModel?> getEvents({
    required int projectId,
    required int offset,
    required bool isActiveProject,
    required bool isFirstAppearance,
    required List<int> positionIds,
    required List<int> classificationIds,
    required List<int> employerIds,
    required String fromDate,
    required String toDate,
  }) =>
      getIt<ApiProvider>()
          .getEvents(
            projectId: projectId,
            offset: offset,
            isActiveProject: isActiveProject,
            classificationIds: classificationIds,
            employerIds: employerIds,
            positionIds: positionIds,
            fromDate: fromDate,
            toDate: toDate,
            isFirstAppearance: isFirstAppearance,
          )
          .timeout(getIt<ApiProvider>().timeout)
          .catchError((dynamic onError) => throw error(onError));
}
