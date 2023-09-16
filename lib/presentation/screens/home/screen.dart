import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(children: [
        const Text('Home Page'),
        TextButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthenticationLogoutRequested());
          },
          child: const Text('Logout'),
        ),
      ]),
    );
  }
}
