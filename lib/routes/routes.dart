import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:washpro/data/repositories/auth/base.dart';
import 'package:washpro/presentation/screens/forgot_password/screen.dart';
import 'package:washpro/presentation/screens/home/screen.dart';
import 'package:washpro/presentation/screens/login/screen.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';
import 'package:washpro/presentation/screens/pick_from_customer/screen.dart';
import 'package:washpro/presentation/screens/pick_up/screen.dart';

enum Routes {
  login,
  forgotPassword,

  home,
  pickUpFromCustomer,
  pickUp,
}

extension RoutesExtension on Routes {
  String get route {
    return '/${toString().split('.').last}';
  }
}

final unauthenticatedRoutes = [
  Routes.login.route,
  Routes.forgotPassword.route,
];

final appRouter = GoRouter(
  initialLocation: Routes.home.route,
  redirect: (BuildContext context, GoRouterState state) {
    bool isAuthenticated = BlocProvider.of<AuthBloc>(context).state.status ==
        AuthenticationStatus.authenticated;

    final path = state.fullPath;

    if (!isAuthenticated && !unauthenticatedRoutes.contains(path)) {
      return Routes.login.route;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: Routes.home.route,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.login.route,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: Routes.forgotPassword.route,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: Routes.pickUpFromCustomer.route,
      builder: (context, state) => const PickFromCustomerScreen(),
    ),
    GoRoute(
      path: Routes.pickUp.route,
      builder: (context, state) {
        return PickUpScreen(customer: state.extra as Customer);
      },
    ),
  ],
);
