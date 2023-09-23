import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/routes/routes.dart';
import 'pickup_card.dart';

class PickFromCustomerScreen extends StatelessWidget {
  const PickFromCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> navigateToHome() async {
      context.go(Routes.home.route);
      return false;
    }

    final customers = [
      Customer(
        number: '#123 | #999',
        name: 'Franderis Mercedes',
        address: '269 S 1st Ave, Mount Vernon, NY 11550',
      ),
      Customer(
        number: '#14569',
        name: 'Frank Pumillo',
        address: '269 S 1st Ave, Mount Vernon, NY 11550',
      ),
    ];

    return WillPopScope(
      onWillPop: navigateToHome,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            goBack: navigateToHome,
            titleTexts: const [
              'PickUp',
              'from',
              'Customer',
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
                        padding: const EdgeInsets.all(6.0),
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 7.0),
                            child: PickupCard(
                              customer: customers[index],
                              onTap: () => {
                                context.push(
                                  Routes.pickUp.route,
                                  extra: customers[index],
                                ),
                              },
                            ),
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
