import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/unauth_wrapper/bloc.dart';
import 'package:washpro/business_logic/cubits/login_screen/cubit.dart';
import 'package:washpro/data/repositories/auth/base.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocProvider<LoginScreenCubit>(
          create: (context) => LoginScreenCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context)),
          child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              final unauthWrapperBloc =
                  BlocProvider.of<UnauthWrapperBloc>(context);
              final loginCubit = BlocProvider.of<LoginScreenCubit>(context);

              return Column(children: [
                const Text('Login Screen'),
                TextButton(
                    onPressed: () =>
                        {loginCubit.login(email: "123", password: '123')},
                    child: const Text('Login')),
                TextButton(
                    onPressed: () => {
                          unauthWrapperBloc
                              .add(NavigateToForgotPasswordScreen())
                        },
                    child: const Text('Forgot Password'))
              ]);
            },
          ),
        ));
  }
}
