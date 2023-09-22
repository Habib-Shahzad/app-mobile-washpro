import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/routes/routes.dart';

class PickFromWashProScreen extends StatelessWidget {
  const PickFromWashProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.go(Routes.home.route);
      return false;
    }

    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            goBack: goBack,
            titleTexts: const [
              'PickUp',
              'from',
              'WashPro',
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tap to Scan ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                PickupCard(
                  customer: Customer(
                    number: "#123",
                    name: "Wash and Fold",
                    address: "WF1003",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                PickupCard(
                  customer: Customer(
                    number: "#14569",
                    name: "Wash and Fold",
                    address: "WF1004",
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
