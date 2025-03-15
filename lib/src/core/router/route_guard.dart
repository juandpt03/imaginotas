import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

class RouteGuard {
  static final Map<Type, List<String>> _allowedRoutes = {
    AuthChecking: [AppRoute.splash.fullPath],
    AuthUnauthenticated: [
      AppRoute.login.fullPath,
      AppRoute.register.fullPath,
      AppRoute.resetPassword.fullPath,
    ],
    AuthAuthenticated: [AppRoute.home.fullPath, AppRoute.note.fullPath],
  };

  static final Map<Type, String> _redirectRoutes = {
    AuthChecking: AppRoute.splash.fullPath,
    AuthUnauthenticated: AppRoute.login.fullPath,
    AuthAuthenticated: AppRoute.home.fullPath,
  };

  static bool isRouteAllowed(String path, AuthState authState) {
    final allowedPaths = _allowedRoutes[authState.runtimeType] ?? [];

    return allowedPaths.any((allowedPath) => allowedPath == path);
  }

  static String? guard(String path, AuthState authState) {
    if (isRouteAllowed(path, authState)) return null;

    return _redirectRoutes[authState.runtimeType];
  }
}
