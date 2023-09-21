import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';

import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_rounded_button.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.pop();
      return false;
    }

    return WillPopScope(
      onWillPop: goBack,
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
            onPressed: goBack,
          ),
          title: Text(
            'Pickup',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Basic Info',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                PickupCard(
                  customer: Customer(
                    number: '123',
                    name: 'Franderis Mercedes',
                    address: '269 S 1st Ave, Mount Vernon, NY 11550',
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 48,
                  child: CustomElevatedButton(
                      buttonText: 'Navigate',
                      isLoading: false,
                      iconData: Icons.location_pin,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Valet Instruction',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                const SizedBox(
                    width: double.maxFinite,
                    child: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("I want contactless pickup please"),
                      ),
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomRoundedButton("No Show"),
                    CustomRoundedButton("Add Notes"),
                    CustomRoundedButton("Scan Bags"),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bag Details',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                SizedBox(
                    width: double.maxFinite,
                    height: 150.0,
                    child: Card(
                      elevation: 10.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          "Order#  ServiceType  Expected  Actual  Variance",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 48,
                  child: CustomElevatedButton(
                      buttonText: 'Picked Up',
                      isLoading: false,
                      iconData: MdiIcons.accountCheck,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }),
                )
              ],
            )),
      ),
    );
  }
}