import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/unauth_wrapper/bloc.dart';
import 'package:washpro/business_logic/cubits/forgot_password_screen/cubit.dart';
import 'package:washpro/data/repositories/auth/base.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),
        body: BlocProvider<ForgotPasswordScreenCubit>(
          create: (context) => ForgotPasswordScreenCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context)),
          child: BlocConsumer<ForgotPasswordScreenCubit,
              ForgotPasswordScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              final unauthWrapperBloc =
                  BlocProvider.of<UnauthWrapperBloc>(context);

              return Column(children: [
                const Text('Forgot Password Screen'),
                TextButton(
                    onPressed: () =>
                        {unauthWrapperBloc.add(NavigateToLoginScreen())},
                    child: const Text('Back to Login'))
              ]);
            },
          ),
        ));
  }
}
