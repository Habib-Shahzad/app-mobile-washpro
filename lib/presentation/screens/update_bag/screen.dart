import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/presentation/widgets/custom_card_dropdown.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';

class UpdateBagScreen extends StatelessWidget {
  const UpdateBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.pop();
      return false;
    }

    PickupCardProps customer = PickupCardProps(
      firstLine: '123',
      secondLine: 'Franderis Mercedes',
      thirdLine: '269 S 1st Ave, Mount Vernon, NY 11550',
    );

    final formKey = GlobalKey<FormBuilderState>();

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
        body: FormBuilder(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Scan Result',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Basic Info',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    PickupCard(
                      customer: PickupCardProps(
                        firstLine: customer.firstLine,
                        secondLine: customer.secondLine,
                        thirdLine: customer.thirdLine,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Deadline',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const CardDropdown(
                      initialValue: 'Item 1',
                      items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                      labelText: 'Select Item',
                      attribute: 'selectedItem',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter Weight ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: FormBuilderTextField(
                          name: "weight",
                          keyboardType: TextInputType.number,
                          initialValue: "0.0",
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                    ),
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
                            if (formKey.currentState!.saveAndValidate()) {
                              // ignore: avoid_print
                              print(formKey.currentState!.value);
                            }
                          }),
                    )
                  ],
                )))),
      ),
    );
  }
}
