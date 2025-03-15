import 'package:go_router/go_router.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';
import 'package:imaginotas/src/features/home/presentation/screens/screens.dart';

class HomeRoutes {
  HomeRoutes._();
  static List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder:
            (context, state) => TransitionManager().slideTransition(
              child: const HomeScreen(),
              state: state,
            ),

        routes: [
          GoRoute(
            path: AppRoute.note.path,
            name: AppRoute.note.name,
            builder:
                (context, state) => NoteView(note: state.extra as NoteEntity?),
          ),
        ],
      ),
    ];
  }
}
