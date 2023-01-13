import 'package:flutter/material.dart';

class EventsSearchData{
  DateTimeRange? selectedDateRange;
  bool isShownActiveProjects = true;
  bool isFirstAppearance  = true;
  String? selectedProject;
  List<String> selectedEmployers = <String>[];
  List<String> selectedPositions = <String>[];
  List<String> selectedClassifications = <String>[];
}