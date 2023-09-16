import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/unauth_wrapper/bloc.dart';
import 'package:washpro/routes/routes.gr.dart';

@RoutePage()
class UnAuthWrapperScreen extends StatelessWidget {
  static const String route = '/unauth';
  const UnAuthWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UnauthWrapperBloc>(
      create: (context) => UnauthWrapperBloc(),
      child: BlocBuilder<UnauthWrapperBloc, UnauthWrapperState>(
        builder: (context, state) {
          return AutoRouter.declarative(routes: (_) {
            return [
              if (state is OnLoginScreen)
                const LoginRoute()
              else if (state is OnForgotPasswordScreen)
                const ForgotPasswordRoute()
            ];
          });
        },
      ),
    );
  }
}
