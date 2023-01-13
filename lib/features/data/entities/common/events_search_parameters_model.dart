class EventsSearchParametersModel {
  const EventsSearchParametersModel({
    required this.fromDate,
    required this.toDate,
    required this.passportID,
    required this.isActiveProject,
    required this.isFirstAppearance,
    required this.projectId,
    required this.employerIds,
    required this.positionIds,
    required this.classificationIds,
  });

  final String fromDate;
  final String toDate;
  final String passportID;
  final int projectId;
  final bool isActiveProject;
  final bool isFirstAppearance;
  final List<int> employerIds;
  final List<int> positionIds;
  final List<int> classificationIds;
}
