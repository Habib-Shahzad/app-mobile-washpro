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
import 'package:washpro/presentation/screens/pick_from_washpro/screen.dart';
import 'package:washpro/presentation/screens/pick_up/screen.dart';
import 'package:washpro/presentation/screens/drop_off/screen.dart';
import 'package:washpro/presentation/screens/print_ticket/screen.dart';
import 'package:washpro/presentation/screens/update_bag/scan_screen.dart';
import 'package:washpro/presentation/screens/update_bag/screen.dart';
import 'package:washpro/temp.dart';

enum Routes {
  empty,

  login,
  forgotPassword,

  home,
  pickUpFromCustomer,
  pickUp,
  updateBagScan,
  updateBagResult,
  dropOff,
  printTicket,
  pickUpFromWashPro,
}

extension RoutesExtension on Routes {
  String get route {
    return '/${toString().split('.').last}';
  }
}

final unauthenticatedRoutes = [
  Routes.empty.route,
  Routes.login.route,
  Routes.forgotPassword.route,
];

final appRouter = GoRouter(
  initialLocation: Routes.empty.route,
  redirect: (BuildContext context, GoRouterState state) {
    if (debugScreen != null) return null;
    AuthenticationStatus status =
        BlocProvider.of<AuthBloc>(context).state.status;

    final path = state.fullPath;

    if (status == AuthenticationStatus.unknown) {
      return Routes.empty.route;
    }

    if (status == AuthenticationStatus.unauthenticated &&
        !unauthenticatedRoutes.contains(path)) {
      return Routes.login.route;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: Routes.empty.route,
      builder: (context, state) {
        return const Center(child: CircularProgressIndicator());
      },
    ),
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
        if (state.extra == null) {
          return Center(
              child: Text('No customer selected',
                  style: Theme.of(context).textTheme.bodyLarge));
        }
        return PickUpScreen(customer: state.extra as Customer);
      },
    ),
    GoRoute(
      path: Routes.dropOff.route,
      builder: (context, state) {
        return const DropOffScreen();
      },
    ),
    GoRoute(
      path: Routes.updateBagScan.route,
      builder: (context, state) {
        return const UpdateBagScanScreen();
      },
    ),
    GoRoute(
      path: Routes.updateBagResult.route,
      builder: (context, state) {
        return const UpdateBagScreen();
      },
    ),
    GoRoute(
      path: Routes.printTicket.route,
      builder: (context, state) {
        return const PrintTicketScreen();
      },
    ),
    GoRoute(
      path: Routes.pickUpFromWashPro.route,
      builder: (context, state) {
        return const PickFromWashProScreen();
      },
    ),
  ],
);
