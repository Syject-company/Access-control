import 'package:get_it/get_it.dart';
import 'package:safe_access/core/services/firebase_messaging_service.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/core/services/pdf_report_service.dart';
import 'package:safe_access/core/values_holder/access_alert_search_data.dart';
import 'package:safe_access/core/values_holder/app_info.dart';
import 'package:safe_access/core/values_holder/employers_data.dart';
import 'package:safe_access/core/values_holder/events_search_data.dart';
import 'package:safe_access/core/values_holder/position_data.dart';
import 'package:safe_access/core/values_holder/projects_data.dart';
import 'package:safe_access/core/values_holder/user_data.dart';
import 'package:safe_access/core/values_holder/user_func_permission.dart';
import 'package:safe_access/core/values_holder/worker_search_data.dart';
import 'package:safe_access/features/data/api_provider.dart';
import 'package:safe_access/features/presentation/resources/app_theme.dart';
import 'package:safe_access/features/presentation/resources/routes/app_routes.dart';
import 'package:safe_access/features/presentation/utils/storage_utils.dart';

GetIt getIt = GetIt.instance;

void setupGitIt() {
  getIt
    ..registerLazySingleton<FirebaseMS>(() => FirebaseMS())
    ..registerLazySingleton<Navigation>(() => Navigation())
    ..registerLazySingleton<AppRoutes>(() => AppRoutes())
    ..registerLazySingleton<ApiProvider>(() => ApiProvider())
    ..registerLazySingleton<AppTheme>(() => AppTheme())
    ..registerLazySingleton<Storage>(() => Storage())
    ..registerLazySingleton<UserFuncPermission>(() => UserFuncPermission())
    ..registerLazySingleton<WorkerSearchData>(() => WorkerSearchData())
    ..registerLazySingleton<EventsSearchData>(() => EventsSearchData())
    ..registerLazySingleton<PDFReportService>(() => PDFReportService())
    ..registerLazySingleton<UserData>(() => UserData())
    ..registerLazySingleton<EmployersData>(() => EmployersData())
    ..registerLazySingleton<ProjectsData>(() => ProjectsData())
    ..registerLazySingleton<PositionsData>(() => PositionsData())
    ..registerLazySingleton<AppInfo>(() => AppInfo())
    ..registerLazySingleton<AccessAlertSearchData>(
        () => AccessAlertSearchData());
}
