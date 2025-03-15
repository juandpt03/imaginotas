import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';

import 'package:imaginotas/src/features/auth/presentation/screens/screens.dart';

class AuthRoutes {
  List<RouteBase> getRoutes() {
    final transitionManager = TransitionManager();
    return [
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder:
            (context, state) => transitionManager.slideTransition(
              state: state,
              child: const LoginScreen(),
            ),
      ),
    ];
  }
}
