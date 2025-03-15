import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/router/route_guard.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginotas/src/features/auth/presentation/routes/auth_routes.dart';
import 'package:imaginotas/src/features/home/presentation/routes/home_routes.dart';

import 'app_route.dart';

class AppRouter {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    routes: [...AuthRoutes().getRoutes(), ...HomeRoutes.getRoutes()],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isGoingTo = state.matchedLocation;
      final redirectPath = RouteGuard.guard(isGoingTo, authState);
      return redirectPath;
    },
  );
}
