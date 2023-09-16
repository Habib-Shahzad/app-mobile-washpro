import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:washpro/data/repositories/auth/app.dart';
import 'package:washpro/data/repositories/auth/base.dart';
import 'package:washpro/data/repositories/user_repository/app.dart';
import 'package:washpro/routes/routes.dart';
import 'package:washpro/routes/routes.gr.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _authRepository = AppAuthRepository();
  final _userRepository = AppUserRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => _authRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                authenticationRepository: _authRepository,
                userRepository: _userRepository),
          ),
        ],
        child: const MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenticationState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: AutoRouterDelegate.declarative(
            _appRouter,
            routes: (_) => [
              // if the user is logged in, they may proceed to the Main App
              if (state.status == AuthenticationStatus.authenticated)
                const AuthWrapperRoute()
              // if they are not logged in, bring them to the Login page
              else if (state.status == AuthenticationStatus.unauthenticated)
                const UnAuthWrapperRoute()
            ],
          ),
          routeInformationParser:
              _appRouter.defaultRouteParser(includePrefixMatches: true),
        );
      },
    );
  }
}
