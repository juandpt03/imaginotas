import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/presentation/bloc/auth/auth_bloc.dart';

import 'package:imaginotas/src/features/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI.setup();
  Bloc.observer = AppBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authUseCases: DI.sl.get()),
        ),
      ],
      child: MultiObserver(
        observers: [(context, child) => LanguageObserver(child: child)],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageBloc>().state;
    final appRouter = AppRouter(authBloc: context.read<AuthBloc>());
    return MaterialApp.router(
      routerConfig: appRouter.router,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      themeMode: ThemeMode.system,
      theme: DI.sl<AppTheme>().lightTheme,
      darkTheme: DI.sl<AppTheme>().darkTheme,
    );
  }
}
