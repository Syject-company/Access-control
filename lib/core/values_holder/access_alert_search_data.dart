import 'package:flutter/material.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';

class AccessAlertSearchData {
  bool isShownActiveProjects = true;
  String selectedProject = '';
  String selectedStatus = StringsRes.notHandled;
  List<String> selectedClassifications = <String>[];
  DateTimeRange? selectedDateRange;
}