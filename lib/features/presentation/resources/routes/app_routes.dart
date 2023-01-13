import 'package:flutter/material.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/screens/access_alerts/access_alerts_screen.dart';
import 'package:safe_access/features/presentation/screens/cameras_alerts/cameras_screen.dart';
import 'package:safe_access/features/presentation/screens/events/events_screen.dart';
import 'package:safe_access/features/presentation/screens/home/home_screen.dart';
import 'package:safe_access/features/presentation/screens/login/login_screen.dart';
import 'package:safe_access/features/presentation/screens/settings/pages/Language.dart';
import 'package:safe_access/features/presentation/screens/settings/settings_screen.dart';
import 'package:safe_access/features/presentation/screens/support/support_screen.dart';
import 'package:safe_access/features/presentation/screens/workers/pages/search/workers_search_screen.dart';
import 'package:safe_access/features/presentation/screens/workers/workers_screen.dart';

class AppRoutes {
  final Map<String, Widget Function(BuildContext context)> routes =
      <String, Widget Function(BuildContext context)>{
    RouteName.login: (BuildContext context) => const LogInScreen(),
    RouteName.home: (BuildContext context) => const HomeScreen(),
    RouteName.accessAlert: (BuildContext context) => const AccessAlertsScreen(),
    RouteName.events: (BuildContext context) => const EventsScreen(),
    RouteName.workers: (BuildContext context) => const WorkersScreen(),
    RouteName.searchWorker: (BuildContext context) =>
        const WorkersSearchScreen(),
    RouteName.cameras: (BuildContext context) => const CamerasScreen(),
    RouteName.settings: (BuildContext context) => const SettingsScreen(),
    RouteName.language: (BuildContext context) => const LanguagePage(),
    RouteName.support: (BuildContext context) => const SupportScreen(),
  };
}
