import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/routes/routes.dart';
import 'pickup_card.dart';

class PickFromCustomerScreen extends StatelessWidget {
  const PickFromCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> navigateToHome() async {
      context.pop();
      return false;
    }

    navigateToPickUp() async {
      context.push(Routes.pickUp.route);
    }

    final customers = [
      Customer(
        number: '123',
        name: 'Franderis Mercedes',
        address: '269 S 1st Ave, Mount Vernon, NY 11550',
      ),
      Customer(
        number: '14569',
        name: 'Frank Pumillo',
        address: '269 S 1st Ave, Mount Vernon, NY 11550',
      ),
    ];

    return WillPopScope(
      onWillPop: navigateToHome,
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
              bottomRight: Radius.circular(20.0), // Adjust the radius as needed
            ),
          ),
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
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          return PickupCard(
                            customer: customers[index],
                            onTap: navigateToPickUp,
                          );
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
