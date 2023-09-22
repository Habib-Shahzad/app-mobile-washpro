import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';

class UpdateBagScreen extends StatelessWidget {
  const UpdateBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.pop();
      return false;
    }

    Customer customer = Customer(
      number: '123',
      name: 'Franderis Mercedes',
      address: '269 S 1st Ave, Mount Vernon, NY 11550',
    );

    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            goBack: goBack,
            titleTexts: const [
              'Update',
              'bag',
              'Status',
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
                    'Scan Result',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
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
                    number: customer.number,
                    name: customer.name,
                    address: customer.address,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Deadline',
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
                        child: Text("Saturday - 23 October 2023"),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add Items',
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
                        child: Text("Select Item"),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Weight ',
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
                        child: Text("0.0"),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 48,
                  child: CustomElevatedButton(
                      buttonText: 'Mark as clean',
                      isLoading: false,
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
