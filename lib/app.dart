import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/scroll/smooth_scroll_behavior.dart';
import 'core/theme/app_theme.dart';
import 'providers/school_data_provider.dart';
import 'router/app_router.dart';

class NbfaScienceApp extends StatelessWidget {
  const NbfaScienceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchoolDataProvider()..loadData(),
      child: MaterialApp.router(
        title: 'NBFA Science College',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        scrollBehavior: const AppScrollBehavior(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
