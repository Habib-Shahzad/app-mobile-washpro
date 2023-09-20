import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/auth_wrapper/bloc.dart';
import 'package:washpro/routes/routes.gr.dart';

Map<Type, dynamic> routeMap = {
  OnHomeScreen: const HomeRoute(),
  OnPickFromCustomerScreen: const PickFromCustomerRoute(),
};

@RoutePage()
class AuthWrapperScreen extends StatelessWidget {
  static const String route = '/auth';
  const AuthWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthWrapperBloc>(
      create: (context) => AuthWrapperBloc(),
      child: BlocBuilder<AuthWrapperBloc, AuthWrapperState>(
        builder: (context, state) {
          return AutoRouter.declarative(routes: (_) {
            return [routeMap[state.runtimeType]];
          });
        },
      ),
    );
  }
}
