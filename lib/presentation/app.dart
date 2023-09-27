import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:washpro/data/repositories/auth/app.dart';
import 'package:washpro/data/repositories/auth/base.dart';
import 'package:washpro/data/repositories/customer/app.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/routes/routes.dart';
import 'package:washpro/styles.dart';
import 'package:washpro/temp.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _authRepository = AppAuthRepository();
  final _customerRepository = AppCustomerRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => _authRepository,
        ),
        RepositoryProvider<CustomerRepository>(
          create: (context) => _customerRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authenticationRepository: _authRepository),
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
        if (debugScreen != null) {
          appRouter.go(debugScreen!.route);
        } else {
          if (state.status == AuthenticationStatus.authenticated) {
            appRouter.go(Routes.home.route);
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            appRouter.go(Routes.login.route);
          }
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
