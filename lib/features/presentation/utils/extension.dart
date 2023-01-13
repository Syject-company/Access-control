import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_access/core/enums/enums.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/values_holder/camera_status_data.dart';
import 'package:safe_access/core/values_holder/classifications_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/features/data/entities/common/alert_details_model.dart';
import 'package:safe_access/features/data/entities/common/employer_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';
import 'package:safe_access/features/data/entities/responses/position_response_model.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/data/entities/responses/search_workers_response_model.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';

import '../resources/text_sizes.dart';

extension AppBarIcon on int {
  int? get appBarHomeIconIndex {
    if (this == 0) {
      return this;
    } else if (this == 2) {
      return 1;
    }
    return null;
  }
}

extension MultiFieldsLabel on List<String> {
  String fieldLabel(List<String> items, String label) {
    if (isEmpty || length == items.length) {
      return label;
    } else if (length == 1) {
      return first;
    }
    return '${StringsRes.selected.tr()} (${length.toString()})';
  }
}

extension ItemsCount on int {
  String showingCount(int showing) {
    return '${StringsRes.showing.tr()}$showing${StringsRes.outOf.tr()}$this ${StringsRes.results.tr()}';
  }
}

extension SubListWorkerSearch on List<SearchWorkersResponseModel> {
  List<SearchWorkersResponseModel> subWorkers(int viewedItemsCont) {
    return sublist(
      viewedItemsCont,
      length >= viewedItemsCont + 5
          ? viewedItemsCont + 5
          : viewedItemsCont + (length - viewedItemsCont),
    );
  }
}

extension SubListAccessAlert on List<AccessAlertResponseModel> {
  List<AccessAlertResponseModel> subAlerts(int viewedItemsCont) {
    return sublist(
      viewedItemsCont,
      length >= viewedItemsCont + 5
          ? viewedItemsCont + 5
          : viewedItemsCont + (length - viewedItemsCont),
    );
  }
}

extension SubListEvents on List<EventsSearchResponseModel> {
  List<EventsSearchResponseModel> subEvents(int viewedItemsCont) {
    return sublist(
      viewedItemsCont,
      length >= viewedItemsCont + 5
          ? viewedItemsCont + 5
          : viewedItemsCont + (length - viewedItemsCont),
    );
  }
}

extension NavIndexSelected on BottomNavTypeSelected {
  int get navIndex {
    switch (this) {
      case BottomNavTypeSelected.logOut:
        return 0;
      case BottomNavTypeSelected.search:
        return 1;
      case BottomNavTypeSelected.newSearch:
        return 2;
      case BottomNavTypeSelected.newSearchDownload:
        return 2;
      case BottomNavTypeSelected.editProfile:
        return 3;
    }
  }
}

extension TextValue on void {
  String textInputted(String first, String second) {
    if (first.isNotEmpty) {
      return first;
    } else if (second.isNotEmpty) {
      return second;
    }
    return '';
  }

  String foundByPhotoAddToProject(
      String project, String passportID, bool isHebrew, int typeId) {
    return '${StringsRes.differentIDPassport.tr()}${typeId == 1 ? StringsRes.id.tr() : StringsRes.passport.tr()}${StringsRes.differentIDPassportNumber.tr()} $passportID'
        '${isHebrew ? StringsRes.notFoundForThisWorker.tr() : ', '}\n${StringsRes.workerFoundByPhotoAddToProject.tr()} ${StringsRes.wantOverrideIDOrProject.tr()}${typeId == 1 ? StringsRes.id.tr() : StringsRes.passport.tr()} ${StringsRes.wantOverrideIDOrProjectAssign.tr()}$project?';
  }

  String foundByPhotoCurrentProject(String passportID, int typeId) {
    return '${StringsRes.differentIDPassport.tr()} ${typeId == 1 ? StringsRes.id.tr() : StringsRes.passport.tr()} ${StringsRes.differentIDPassportNumber.tr()} $passportID'
        ', \n${StringsRes.workerFoundByPhotoCurrentProject.tr()} ${StringsRes.wantOverrideID.tr()}${typeId == 1 ? StringsRes.id.tr() : StringsRes.passport.tr()}?';
  }
}

extension WorkerRegisterNotifyType on WorkerRegisterNotify {
  String notifyText(
      {String? oldPassportId,
      String? projectName,
      String? selectedPassportId}) {
    switch (this) {
      case WorkerRegisterNotify.registeredSuccess:
        return '$oldPassportId ${StringsRes.registeredSuccess.tr()}';
      case WorkerRegisterNotify.assignedTo:
        return '$oldPassportId ${StringsRes.assignedTo.tr()} $projectName';
      case WorkerRegisterNotify.nameIdUpdated:
        return '$oldPassportId ${StringsRes.nameIdUpdated.tr()} $selectedPassportId';
    }
  }
}

extension DateTimeRangeExtension on DateTimeRange {
  String get formattedRangeDate {
    return '${DateFormat('dd-MM-yyyy').format(start)}'
        ' - ${DateFormat('dd-MM-yyyy').format(end)}';
  }
}

extension AccessAlertStateSelected on String {
  bool get stateStatus => this == StringsRes.handled;
}

extension EventHeaderBoxTitle on List<String> {
  String boxTitle(String type, int itemsCount) {
    if (isEmpty || length == itemsCount) {
      return '${type.tr()}: ${StringsRes.all.tr()}';
    } else if (length == 1) {
      return '${type.tr()}: $first';
    }
    return '${type.tr()}: ${StringsRes.selected.tr()} (${length.toString()})';
  }
}

extension PhotoCaptureTextIndex on WorkerPhotoCaptureTextType {
  int get textIndex {
    switch (this) {
      case WorkerPhotoCaptureTextType.clickCapture:
        return 0;
      case WorkerPhotoCaptureTextType.captureSuccessful:
        return 1;
    }
  }
}

extension CheckPermissionNavigation on String {
  bool get isLaunchAllowed {
    switch (this) {
      case RouteName.accessAlert:
        return getIt<UserFuncPermission>().isCanViewAccessAlerts;
      case RouteName.workers:
        return getIt<UserFuncPermission>().isCanViewWorkers &&
            getIt<ProjectsData>().projects.isPermittedPerformAction;
      case RouteName.events:
        return getIt<UserFuncPermission>().isCanViewEvents;
      case RouteName.cameras:
        return getIt<UserFuncPermission>().isCanViewHardwareAlerts;
      case RouteName.settings:
        return true;
      case RouteName.support:
        return true;
      default:
        return true;
    }
  }
}

extension CheckPermissionsValue on List<int>? {
  bool isAllowed(int code) {
    if (this != null && this!.isNotEmpty) {
      return this!.contains(code);
    } else {
      return false;
    }
  }
}

extension ReturnEmployerNames on List<EmployerModel>? {
  List<String> get namesEmp {
    return this?.map((EmployerModel e) => e.name ?? '').toList() ?? <String>[];
  }

  String nameEmployer(int? id) {
    return id != null
        ? this?.where((EmployerModel e) => e.id == id).first.name ?? 'N/A'
        : 'N/A';
  }

  List<int> employersId(List<String> employers) {
    return this
            ?.where((EmployerModel e) => employers.contains(e.name))
            .map((EmployerModel e) => e.id != null ? e.id! : 0)
            .toList() ??
        <int>[];
  }
}

extension ReturnClassifications on List<ClassificationsData> {
  List<String> get namesClassification {
    return map((ClassificationsData e) => e.name).toList();
  }

  String nameClassification(int? id) {
    return id != null
        ? where((ClassificationsData e) => e.id == id).first.name
        : 'N/A';
  }

  List<int> classificationId(List<String> classifications) {
    return where((ClassificationsData e) => classifications.contains(e.name))
        .map((ClassificationsData e) => e.id)
        .toList();
  }
}

extension ReturnPositionNames on List<PositionResponseModel>? {
  List<String> get namesPos {
    return this?.map((PositionResponseModel e) => e.name ?? '').toList() ??
        <String>[];
  }

  String namePosition(int? id) {
    return id != null
        ? this?.where((PositionResponseModel e) => e.id == id).first.name ??
            'N/A'
        : 'N/A';
  }

  List<int> positionsId(List<String> positions) {
    return this
            ?.where((PositionResponseModel e) => positions.contains(e.name))
            .map((PositionResponseModel e) => e.id)
            .toList() ??
        <int>[];
  }
}

extension ReturnProjectNames on List<ProjectResponseModel>? {
  List<String> get namesActive {
    return this
            ?.where((ProjectResponseModel e) => e.isActive)
            .map((ProjectResponseModel e) => e.name)
            .toList() ??
        <String>[];
  }

  bool isActive(String name) {
    return this
            ?.where((ProjectResponseModel e) => name == e.name)
            .first
            .isActive ??
        false;
  }

  String nameProject(int? id) {
    return id != null
        ? this?.where((ProjectResponseModel e) => e.id == id).first.name ??
            'N/A'
        : 'N/A';
  }

  List<String> get namesActiveAndNotActive {
    return this?.map((ProjectResponseModel e) => e.name).toList() ?? <String>[];
  }

  int projectId(String project) {
    return this
            ?.where((ProjectResponseModel e) => e.name == project)
            .map((ProjectResponseModel e) => e.id)
            .first ??
        0;
  }

  bool projectIsActive(String project) {
    return this != null &&
            this!.isNotEmpty &&
            this!.any((ProjectResponseModel e) => e.name == project) &&
            this!
                .where((ProjectResponseModel e) => e.name == project)
                .map((ProjectResponseModel e) => e.isActive)
                .first;
  }

  String? nameLastProject(String? project) {
    return this != null && this!.isNotEmpty && project != null
        ? this!.any((ProjectResponseModel e) => e.name == project)
            ? this
                ?.where((ProjectResponseModel e) => e.name == project)
                .first
                .name
            : null
        : null;
  }
}

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('dd-MM-yyyy HH:mm')
      .format(DateTime.utc(year, month, day, hour, minute, second).toLocal());

  String get formattedRangeToDate => DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
      .format(DateTime(year, month, day, 23, 59, 59, 999));

  String get formattedDateWithOutTime => DateFormat('dd-MM-yyyy')
      .format(DateTime.utc(year, month, day, hour, minute, second).toLocal());

  String get formattedTime => DateFormat('HH:mm')
      .format(DateTime.utc(year, month, day, hour, minute, second).toLocal());
}

extension AlertAddressInfo on AlertDetailsModel? {
  String get address =>
      '$_projectName $_buildingName $_floorName $_entranceName';

  String get _projectName =>
      this?.project?.name != null ? '${this?.project?.name},' : '';

  String get _buildingName => this?.hardware?.building?.name != null
      ? '${this?.hardware?.building?.name},'
      : '';

  String get _floorName => this?.hardware?.floor?.name != null
      ? '${this?.hardware?.floor?.name},'
      : '';

  String get _entranceName => this?.hardware?.entrance?.name != null
      ? '${this?.hardware?.entrance?.name}'
      : '';
}

extension ListSizeTest on List<dynamic>? {
  bool get isPermittedPerformAction {
    if (this != null && this!.isNotEmpty) {
      return true;
    }
    Fluttertoast.showToast(
      msg: StringsRes.noPermission.tr(),
      backgroundColor: Colors.grey,
      fontSize: TextSizes.sp16.sp,
    );
    return false;
  }
}

extension CheckPassportIdField on String {
  bool isEnable(bool isPassport) {
    return (isPassport && isNotEmpty) ||
        (!isPassport && isNotEmpty && length >= 9);
  }

  bool get isValid {
    if (int.tryParse(this) != null && int.tryParse(this)! / 0.5 == 0) {
      Fluttertoast.showToast(
        msg: StringsRes.notValidNumber.tr(),
        backgroundColor: Colors.grey,
        fontSize: TextSizes.sp16.sp,
      );
      return false;
    }
    return true;
  }
}

extension CamerasStatusTitle on List<CameraStatusData> {
  String nameCameraStatus(int? id) {
    return id != null
        ? where((CameraStatusData e) => e.id == id).first.name
        : 'N/A';
  }

  String nameCameraStatusDesc(int? id) {
    return id != null
        ? where((CameraStatusData e) => e.id == id).first.description
        : '';
  }
}
