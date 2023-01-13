import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_access/core/services/data_dog_events.dart';
import 'package:safe_access/core/services/firebase_messaging_service.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/values_holder/employers_data.dart';
import 'package:safe_access/core/values_holder/position_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/user_data.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/features/data/entities/common/employer_model.dart';
import 'package:safe_access/features/data/entities/requests/firebase_token_request_model.dart';
import 'package:safe_access/features/data/entities/requests/handle_access_alert_request_model.dart';
import 'package:safe_access/features/data/entities/responses/access_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/camera_alert_response_model.dart';
import 'package:safe_access/features/data/entities/responses/position_response_model.dart';
import 'package:safe_access/features/data/entities/responses/project_response_model.dart';
import 'package:safe_access/features/data/entities/responses/user_data_response_model.dart';
import 'package:safe_access/features/domain/repositories/access_alert_manager.dart';
import 'package:safe_access/features/domain/repositories/camera_alert_manager.dart';
import 'package:safe_access/features/domain/repositories/home_manager.dart';
import 'package:safe_access/features/domain/repositories/user_manager.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_event.dart';
import 'package:safe_access/features/presentation/screens/home/bloc/home_state.dart';
import 'package:safe_access/features/presentation/screens/home/pages/home_access_alert_details.dart';
import 'package:safe_access/features/presentation/screens/home/pages/home_cameras_alert_details.dart';
import 'package:safe_access/features/presentation/utils/extension.dart'
    show CheckPermissionNavigation, CheckPermissionsValue;
import 'package:safe_access/features/presentation/utils/storage_utils.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>
    with HomeManager, UserManager, AccessAlertManager, CameraAlertManager {
  HomeBloc() : super(HomeInitial()) {
    on<ResponseProjEmplPosition>(
      (ResponseProjEmplPosition event, Emitter<HomeState> emit) async {
        await _getUserData(emit: emit).catchError((dynamic onError) {
          emit(const FCMDataLoadingShown(isShown: false));
        });
      },
    );
    on<UpdateFirebaseToken>(
      (UpdateFirebaseToken event, Emitter<HomeState> emit) async {
        await _updateFirebaseToken(isDelete: false)
            .whenComplete(
                () => emit(FirebaseTokenUpdated(updateKey: UniqueKey())))
            .catchError((dynamic onError) {
          emit(const FCMDataLoadingShown(isShown: false));
        });
      },
    );
    on<CheckFCMDataEmpty>(
      (CheckFCMDataEmpty event, Emitter<HomeState> emit) async {
        await _checkFCMData(emit: emit)
            .then((bool value) => emit(FCMDataLoadingShown(isShown: value)))
            .catchError((dynamic onError) =>
                emit(const FCMDataLoadingShown(isShown: false)));
      },
    );
    on<LaunchPage>(
      (LaunchPage event, Emitter<HomeState> emit) {
        //Todo: when the ready on back
        //emit(const AccessAlertCount(alertCount: 0));
        _launchPage(route: event.route);
      },
    );
    on<ShowLogOutDialog>(
      (ShowLogOutDialog event, Emitter<HomeState> emit) {
        emit(LogOutDialogShown(updateKey: UniqueKey()));
      },
    );
    on<LogOut>(
      (LogOut event, Emitter<HomeState> emit) async {
        await _logOut(emit: emit);
      },
    );
    on<HandleHardwareAlert>(
      (HandleHardwareAlert event, Emitter<HomeState> emit) async {
        await _handleHardAlert(emit: emit, id: event.id);
      },
    );
    on<HandleAccessAlert>(
      (HandleAccessAlert event, Emitter<HomeState> emit) async {
        await _handleAccessAlert(
          emit: emit,
          id: event.id,
          alertType: event.alertType,
        );
      },
    );
    on<ShowFCMDataLoading>(
      (ShowFCMDataLoading event, Emitter<HomeState> emit) async {
        await Future<dynamic>.delayed(const Duration(seconds: 2));
        emit(FCMDataLoadingShown(isShown: event.isShown));
      },
    );
    on<ReloadTheAlertImage>(
      (ReloadTheAlertImage event, Emitter<HomeState> emit) {
        emit(TheAlertImageReloaded(
            imageUrl: event.imageUrl, updateKey: UniqueKey()));
      },
    );
  }

  Future<void> _getUserData({required Emitter<HomeState> emit}) =>
      getUserData().then((UserDataResponseModel model) {
        getIt<UserData>()
          ..id = model.id
          ..username = model.username
          ..language = model.language
          ..permissions = model.permissions
          ..projects = model.projects;
        //Note: when user not admin
        getIt<ProjectsData>().projects = model.projects;
        logInfo('Get user data success for ${model.username}');
        _permissions(model.permissions);
      }).then((Object? value) async {
        await _getUserProjEmplPositionData().whenComplete(
            () => emit(ProjEmplPositionRespond(updateKey: UniqueKey())));
      });

  Future<void> _getUserProjEmplPositionData() async {
    await Future.wait([
      getProjects().then((List<ProjectResponseModel> data) =>
          getIt<ProjectsData>().projects = data),
      getEmployers().then((List<EmployerModel> data) =>
          getIt<EmployersData>().employers = data),
      getPositions().then((List<PositionResponseModel> data) =>
          getIt<PositionsData>().positions = data),
    ]);
  }

  Future<void> _permissions(List<int>? perm) async {
    getIt<UserFuncPermission>()
      ..isCanViewAccessAlerts = perm.isAllowed(300) //300
      ..isCanHandleAccessAlerts = perm.isAllowed(310) //310
      ..isCanViewEvents = perm.isAllowed(301) //301
      ..isCanViewWorkers = perm.isAllowed(302) //302
      ..isCanEditAddWorkers = perm.isAllowed(312) //312
      ..isCanViewHardwareAlerts = perm.isAllowed(201) //201
      ..isCanHandleHardwareAlerts = perm.isAllowed(313); //313
  }

  Future<void> _updateFirebaseToken({required bool isDelete}) async {
    final String? _token = await getIt<FirebaseMS>().token;
    final String? _id = await _deviceID;
    debugPrint('Firebase token: $_token - DeviceID: $_id');
    logInfo('Firebase token: $_token - DeviceID: $_id');
    if (_token != null && _id != null) {
      await updateFCMToken(
          model: FirebaseTokenRequestModel(
        deviceId: _id,
        fcmToken: _token,
        isDelete: isDelete,
      ));
    }
  }

  Future<String?> get _deviceID async {
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        identifier = build.id; //UUID for Android
      } else if (Platform.isIOS) {
        final IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
    return identifier;
  }

  void _launchPage({required String route}) {
    if (route.isLaunchAllowed) {
      getIt<Navigation>().to(route);
      logInfo('Home screen navigated to $route');
    } else {
      logWarn('No permission to navigate to $route');
      Fluttertoast.showToast(
        msg: StringsRes.noPermission,
        backgroundColor: Colors.grey,
        fontSize: TextSizes.sp16.sp,
      );
    }
  }

  Future<void> _logOut({required Emitter<HomeState> emit}) =>
      _updateFirebaseToken(isDelete: true)
          .then(
        (dynamic value) => logout().then((dynamic value) async {
          WebviewCookieManager().clearCookies();
          await getIt<Storage>().setIsLoggedIn(StringsRes.isLoggedOut);
          getIt<Navigation>().toRemoveUntil(RouteName.login);
          debugPrint('Firebase Token is deleted!');
          logInfo('The user is logged out');
        }).catchError((dynamic onError) {
          logError('Logging out error: $onError');
          emit(LogOutError(updateKey: UniqueKey()));
        }),
      )
          .catchError((dynamic onError) {
        emit(LogOutError(updateKey: UniqueKey()));
      });

  Future<bool> _checkFCMData({required Emitter<HomeState> emit}) async {
    bool _isLoadingShown = false;
    await getIt<FirebaseMS>()
        .fcmDataTerminated
        .then((RemoteMessage? message) async {
      final String _msgID = await getIt<Storage>().getFCMMessageID();

      debugPrint('getInitialMessage: ${message?.data}');
      _isLoadingShown = message != null && message.data != null;

      if (message != null &&
          message.data != null &&
          message.messageId != null &&
          _msgID != message.messageId) {
        await getIt<Storage>()
            .setFCMMessageID(message.messageId!)
            .then((dynamic value) async {
          if (message.data['alertType'] == 'hardware') {
            logInfo('Notification: received Hardware alert');
            await getHardwareAlertFromNotification(
                    alertId: int.parse(message.data['alertId'] as String))
                .then((CameraAlertResponseModel model) {
              if (model != null) {
                _launchHardwareAlertDetails(model);
              }
            });
          } else {
            logInfo('Notification: received Access alert');
            await getAlertFromNotification(
                    alertId: int.parse(message.data['alertId'] as String),
                    alertType: message.data['alertType'] as String)
                .then((AccessAlertResponseModel model) {
              if (model != null) {
                _launchAccessAlertDetails(model);
              }
            });
          }
        });
      }
    });

    getIt<FirebaseMS>().fcmDataBackground.listen((RemoteMessage event) async {
      debugPrint('onMessageOpenedApp: ${event.data}');

      final String _msgID = await getIt<Storage>().getFCMMessageID();
      _isLoadingShown = event.data.isNotEmpty;

      if (event.data.isNotEmpty &&
          event.messageId != null &&
          _msgID != event.messageId) {
        await getIt<Storage>()
            .setFCMMessageID(event.messageId!)
            .then((dynamic value) async {
          if (event.data['alertType'] == 'hardware') {
            await getHardwareAlertFromNotification(
                    alertId: int.parse(event.data['alertId'] as String))
                .then((CameraAlertResponseModel model) {
              if (model != null) {
                _launchHardwareAlertDetails(model);
              }
            });
          } else {
            await getAlertFromNotification(
                    alertId: int.parse(event.data['alertId'] as String),
                    alertType: event.data['alertType'] as String)
                .then((AccessAlertResponseModel model) {
              if (model != null) {
                _launchAccessAlertDetails(model);
              }
            });
          }
        });
      }
    });
    return _isLoadingShown;
  }

  void _launchAccessAlertDetails(AccessAlertResponseModel model) {
    getIt<Navigation>().toPageRouteProvider<HomeAccessAlertDetails, HomeBloc>(
      page: HomeAccessAlertDetails(
        model: model,
        image: model.person?.image?.imgUrl ?? model.image?.imgUrl ?? '',
        isCanHandle: getIt<UserFuncPermission>().isCanHandleAccessAlerts,
      ),
      bloc: this,
    );
  }

  void _launchHardwareAlertDetails(CameraAlertResponseModel model) {
    getIt<Navigation>().toPageRouteProvider<HomeCamerasAlertDetails, HomeBloc>(
      page: HomeCamerasAlertDetails(
        model: model,
        isCanHandle: getIt<UserFuncPermission>().isCanHandleHardwareAlerts,
      ),
      bloc: this,
    );
  }

  Future<void> _handleHardAlert(
          {required Emitter<HomeState> emit, required num id}) =>
      handleHardAlert(id: id).then((dynamic value) async {
        logInfo('Notification: handled Hardware alert, id:$id');
        getIt<Navigation>().pop();
      });

  Future<void> _handleAccessAlert(
          {required Emitter<HomeState> emit,
          required int id,
          required String alertType}) =>
      handleAccessAlert(
          model: HandleAccessAlertRequestModel(
        alertId: id,
        alertType: alertType,
      )).then((dynamic value) async {
        logInfo('Notification: handled Access alert, id:$id');
        getIt<Navigation>().pop();
      });
}
