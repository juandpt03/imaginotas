import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/features/auth/presentation/routes/auth_routes.dart';
import 'package:imaginotas/src/features/home/presentation/routes/home_routes.dart';

import 'app_route.dart';

class AppRouter {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.login.path,
    debugLogDiagnostics: true,
    routes: [...AuthRoutes().getRoutes(), ...HomeRoutes.getRoutes()],
  );
}
