import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:washpro/data/repositories/auth/app.dart';
import 'package:washpro/data/repositories/auth/base.dart';
import 'package:washpro/data/repositories/user_repository/app.dart';
import 'package:washpro/routes/routes.dart';
import 'package:washpro/styles.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthenticationState>(
      builder: (context, state) {
        bool isAuthenticated =
            state.status == AuthenticationStatus.authenticated;

        if (isAuthenticated) {
          appRouter.go(Routes.home.route);
        } else {
          appRouter.go(Routes.login.route);
        }

        return MaterialApp.router(
          routerConfig: appRouter,
          localizationsDelegates: const [FormBuilderLocalizations.delegate],
          debugShowCheckedModeBanner: false,
          theme: Styles.mainTheme,
        );
      },
    );
  }
}
