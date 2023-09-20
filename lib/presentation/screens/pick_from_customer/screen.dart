import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/auth_wrapper/bloc.dart';

import 'pickup_card.dart';

@RoutePage()
class PickFromCustomerScreen extends StatelessWidget {
  const PickFromCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> navigateToHome() async {
      BlocProvider.of<AuthWrapperBloc>(context).add(NavigateToHomeScreen());
      return false;
    }

    return WillPopScope(
      onWillPop: navigateToHome,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: navigateToHome,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'Pick',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'from',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              Text(
                'Customer',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              PickupCard(
                customer: Customer(
                  number: '123',
                  name: 'Franderis Mercedes',
                  address: '269 S 1st Ave, Mount Vernon, NY 11550',
                ),
              ),
              PickupCard(
                customer: Customer(
                  number: '14569',
                  name: 'Frank Pumillo',
                  address: '269 S 1st Ave, Mount Vernon, NY 11550',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
