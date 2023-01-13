import 'package:safe_access/core/values_holder/camera_status_data.dart';
import 'package:safe_access/core/values_holder/classifications_data.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';

class ItemsData {
  static const List<ClassificationsData> classifications =
      <ClassificationsData>[
    ClassificationsData(id: 5, name: StringsRes.blocked),
    ClassificationsData(id: 12, name: StringsRes.blockedRecently),
    ClassificationsData(id: 11, name: StringsRes.exceptionPending),
    ClassificationsData(id: 9, name: StringsRes.existsNotAssign),
    ClassificationsData(id: 3, name: StringsRes.inactive),
    ClassificationsData(id: 7, name: StringsRes.inactiveBlocked),
    ClassificationsData(id: 10, name: StringsRes.pendingPermission),
    ClassificationsData(id: 1, name: StringsRes.permittedActive),
    ClassificationsData(id: 13, name: StringsRes.unidentified),
    ClassificationsData(id: 2, name: StringsRes.unPermitted),
    ClassificationsData(id: 6, name: StringsRes.unPermittedBlocked),
    ClassificationsData(id: 4, name: StringsRes.unPermittedInactive),
    ClassificationsData(id: 8, name: StringsRes.unPermittedInactiveBlocked),
  ];

  static const List<String> accessAlertStatus = <String>[
    StringsRes.notHandled,
    StringsRes.handled,
  ];

  static const List<CameraStatusData> cameraStatus = <CameraStatusData>[
    CameraStatusData(id: 0, name: StringsRes.caIdle, description: ''),
    CameraStatusData(
      id: 1,
      name: StringsRes.caActive,
      description: StringsRes.caActiveDesc,
    ),
    CameraStatusData(
      id: 3,
      name: StringsRes.caAborted,
      description: StringsRes.caAbortedDesc,
    ),
    CameraStatusData(
      id: 5,
      name: StringsRes.caAnalyzeTimeout,
      description: StringsRes.caAnalyzeTimeoutDesc,
    ),
    CameraStatusData(
      id: 6,
      name: StringsRes.caInputError,
      description: StringsRes.caInputErrorDesc,
    ),
    CameraStatusData(
      id: 7,
      name: StringsRes.caAttemptingReconnect,
      description: StringsRes.caAttemptingReconnectDesc,
    ),
    CameraStatusData(
      id: 8,
      name: StringsRes.caErrorStarting,
      description: StringsRes.caErrorStartingDesc,
    ),
    CameraStatusData(
      id: 9,
      name: StringsRes.caErrorStopping,
      description: StringsRes.caErrorStoppingDesc,
    ),
    CameraStatusData(
      id: 10,
      name: StringsRes.caNonResponsive,
      description: StringsRes.caNonResponsiveDesc,
    ),
    CameraStatusData(id: 11, name: StringsRes.caDisplay, description: ''),
  ];
}
