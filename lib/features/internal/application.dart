import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_access/core/services/getIt.dart';
import 'package:safe_access/core/services/navigation.dart';
import 'package:safe_access/features/presentation/resources/app_theme.dart';
import 'package:safe_access/features/presentation/resources/routes/app_routes.dart';
import 'package:safe_access/features/presentation/resources/routes/route_name.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';

class SafeAccess extends StatelessWidget {
  const SafeAccess({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 832),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: StringsRes.appName,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: getIt<AppTheme>().materialThemeData,
        navigatorKey: getIt<Navigation>().navigatorKey,
        initialRoute: isLoggedIn ? RouteName.home : RouteName.login,
        routes: getIt<AppRoutes>().routes,
      ),
    );
  }
}
