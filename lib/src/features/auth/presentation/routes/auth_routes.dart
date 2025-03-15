import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/screens/screens.dart';

class AuthRoutes {
  List<RouteBase> getRoutes() {
    final transitionManager = TransitionManager();
    return [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        pageBuilder:
            (context, state) => transitionManager.scaleFadeTransitionPage(
              state: state,
              child: const SplashScreen(),
            ),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder:
            (context, state) => transitionManager.slideTransition(
              state: state,
              child: const LoginScreen(),
            ),
      ),

      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        pageBuilder:
            (context, state) => transitionManager.slideTransition(
              state: state,
              child: const RegisterScreen(),
            ),
      ),

      GoRoute(
        path: AppRoute.resetPassword.path,
        name: AppRoute.resetPassword.name,
        pageBuilder:
            (context, state) => transitionManager.slideTransition(
              state: state,
              child: const ResetPasswordScreen(),
            ),
      ),
    ];
  }
}
