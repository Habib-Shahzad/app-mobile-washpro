import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/cubits/print_screen/cubit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';
import 'package:washpro/presentation/widgets/card_text_field.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';

class PrintBagScreenProps {
  final Bag bag;

  PrintBagScreenProps({
    required this.bag,
  });
}

class PrintBagScreen extends StatelessWidget {
  final PrintBagScreenProps props;
  const PrintBagScreen({super.key, required this.props});

  String formatDate(String input) {
    DateTime dateTime = DateTime.parse(input);
    String dayOfWeek = DateFormat('EEEE').format(dateTime);
    String day = DateFormat('d').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('y').format(dateTime);

    return '$dayOfWeek - $day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.pop();
      return false;
    }

    final formKey = GlobalKey<FormBuilderState>();

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
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Print Ticket",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
        body: FormBuilder(
            key: formKey,
            child: BlocProvider(
              create: (context) => PrintScreenCubit(
                customerRepo:
                    RepositoryProvider.of<CustomerRepository>(context),
                bagRepo: RepositoryProvider.of<BagRepository>(context),
              )..loadOrder(props.bag.order_id!),
              child: BlocListener<PrintScreenCubit, PrintScreenState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage!),
                      ),
                    );
                  }
                },
                child: BlocBuilder<PrintScreenCubit, PrintScreenState>(
                  builder: (context, state) {
                    final cubit = BlocProvider.of<PrintScreenCubit>(context);

                    if (state.initialLoading == false) {
                      OrderWithBags order = state.order!;

                      DefaultCardProps cardProps = DefaultCardProps(
                        firstLine: order.customer.customer_id,
                        secondLine: order.customer.name,
                        thirdLine: order.customer.address,
                      );

                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Basic Info',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ),
                              DefaultCard(
                                props: DefaultCardProps(
                                  firstLine: cardProps.firstLine,
                                  secondLine: cardProps.secondLine,
                                  thirdLine: cardProps.thirdLine,
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
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ),
                              SizedBox(
                                  width: double.maxFinite,
                                  child: Card(
                                    elevation: 10.0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                          formatDate(order.due_date ?? '')),
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Add Items ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ),
                              FormBuilderCardTextField(
                                initialValue: props.bag.item_count != null
                                    ? props.bag.item_count.toString()
                                    : '-',
                                name: 'items_count',
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.integer(),
                                ],
                              ),
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
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                              ),
                              FormBuilderCardTextField(
                                initialValue: props.bag.item_count != null
                                    ? props.bag.weight.toString()
                                    : '-',
                                name: 'bag_weight',
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                height: 48,
                                child: CustomElevatedButton(
                                    buttonText: 'Print Ticket',
                                    isLoading: state.printLoading == true,
                                    onPressed: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (formKey.currentState!
                                          .saveAndValidate()) {
                                        final values =
                                            formKey.currentState!.value;

                                        String itemsCount =
                                            values['items_count'];
                                        String bagWeight = values['bag_weight'];

                                        bool success = await cubit.printTicket(
                                            props.bag, bagWeight, itemsCount);

                                        if (context.mounted && success) {
                                          context.pop();
                                        }
                                      }
                                    }),
                              )
                            ],
                          )));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
