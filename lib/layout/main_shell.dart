import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../providers/school_data_provider.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const List<_NavItem> _navItems = [
    _NavItem('Home', '/'),
    _NavItem('Academics', '/academics'),
    _NavItem('Calendar', '/calendar'),
    _NavItem('Documents', '/documents'),
    _NavItem('Admissions', '/admissions'),
    _NavItem('Gallery', '/gallery'),
    _NavItem('Contact', '/contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < 900;
    final title = context.select<SchoolDataProvider, String>(
      (provider) => provider.data?.metadata.abbreviation ?? 'NBFA',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: mobile
            ? null
            : [
                ..._navItems.map(
                  (item) => TextButton(
                    onPressed: () => context.go(item.path),
                    child: Text(item.label),
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () => context.go('/admissions'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.accentCrimson,
                  ),
                  child: const Text('Apply Now'),
                ),
                const SizedBox(width: 18),
              ],
      ),
      drawer: mobile
          ? Drawer(
              child: SafeArea(
                child: ListView(
                  children: [
                    const ListTile(
                      title: Text('NBFA Science College'),
                      subtitle: Text('science.nbfa.edu.np'),
                    ),
                    const Divider(),
                    ..._navItems.map(
                      (item) => ListTile(
                        title: Text(item.label),
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go(item.path);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: child,
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.path);

  final String label;
  final String path;
}
