import 'package:go_router/go_router.dart';

import '../layout/main_shell.dart';
import '../pages/academics_page.dart';
import '../pages/admissions_page.dart';
import '../pages/calendar_page.dart';
import '../pages/contact_page.dart';
import '../pages/documents_page.dart';
import '../pages/gallery_page.dart';
import '../pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      _route(path: '/', child: const HomePage()),
      _route(path: '/academics', child: const AcademicsPage()),
      _route(path: '/calendar', child: const CalendarPage()),
      _route(path: '/documents', child: const DocumentsPage()),
      _route(path: '/admissions', child: const AdmissionsPage()),
      _route(path: '/gallery', child: const GalleryPage()),
      _route(path: '/contact', child: const ContactPage()),
    ],
  );

  static GoRoute _route({required String path, required dynamic child}) {
    return GoRoute(
      path: path,
      builder: (context, state) => MainShell(child: child),
    );
  }
}
