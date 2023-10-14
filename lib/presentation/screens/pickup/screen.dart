import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/business_logic/cubits/pickup_screen/cubit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/models/bag_detail_row.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';

import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_rounded_button.dart';
import 'package:washpro/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ManageOrderProps {
  final Customer customer;
  const ManageOrderProps({required this.customer});
}

class ManageOrderScreen extends StatelessWidget {
  final ManageOrderProps props;
  const ManageOrderScreen({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    Customer customer = props.customer;

    getDataColumn(String text) {
      TextStyle? style = Theme.of(context).textTheme.bodySmall;

      return DataColumn(
        label: Text(
          text,
          style: style,
        ),
        numeric: false,
      );
    }

    DataCell getDataCell(String text) {
      return DataCell(
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    DataRow getDataRow(BagDetailRow bagDetail) {
      return DataRow(
        cells: <DataCell>[
          getDataCell(bagDetail.orderNumber),
          getDataCell(defaultLabeler(bagDetail.serviceType)),
          getDataCell(defaultLabeler(bagDetail.actual)),
          getDataCell(bagDetail.expected),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        leading: IconButton(
          icon: kIsWeb
              ? const Icon(Icons.arrow_back)
              : Platform.isAndroid
                  ? const Icon(Icons.arrow_back)
                  : const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go(Routes.pickFromCustomer.route);
          },
        ),
        title: Text(
          'Pickup',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.location_pin),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocProvider<PickupScreenCubit>(
        create: (context) => PickupScreenCubit(
            customerRepository:
                RepositoryProvider.of<CustomerRepository>(context))
          ..getCustomerOrders(customer.id.toString()),
        child: BlocListener<PickupScreenCubit, PickupScreenState>(
          listener: (context, state) {
            if (state.addingBag == AddedBagStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Bag added successfully'),
              ));
            } else if (state.addingBag == AddedBagStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Bag addition failed'),
              ));
            }
          },
          child: BlocBuilder<PickupScreenCubit, PickupScreenState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<PickupScreenCubit>(context);

              if (state.initialLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.initialLoading == false && state.orders != null) {
                List<OrderWithBags> orders = state.orders!;

                List<BagDetailRow> rows = [];

                for (OrderWithBags order in orders) {
                  rows.add(BagDetailRow(
                    orderNumber: order.id.toString(),
                    serviceType: order.bags[0].bag_type,
                    expected: order.expected_bag_count.toString(),
                    actual: order.bags.length.toString(),
                    variance:
                        (order.expected_bag_count!.toInt() - order.bags.length)
                            .toString(),
                  ));
                }

                final List<DataRow> dataRows = rows.map((BagDetailRow row) {
                  return getDataRow(row);
                }).toList();

                return SingleChildScrollView(
                  child: Padding(
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
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                          DefaultCard(
                            props: DefaultCardProps(
                              firstLine: customer.name,
                              secondLine: customer.address,
                              thirdLine: customer.name,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 48,
                            child: CustomElevatedButton(
                                buttonText: 'Scan Bag',
                                isLoading: false,
                                iconData: Icons.camera,
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  List<DropdownMenuItem<String>> orderOptions =
                                      rows.map<DropdownMenuItem<String>>(
                                          (BagDetailRow row) {
                                    return DropdownMenuItem<String>(
                                      value: row.orderNumber,
                                      child: Text(
                                          '${row.orderNumber} - ${defaultLabeler(row.serviceType)}'),
                                    );
                                  }).toList();

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String selectedValue =
                                          rows[0].orderNumber;

                                      return StatefulBuilder(
                                        builder: (BuildContext alertBoxContext,
                                            StateSetter setState) {
                                          return AlertDialog(
                                            title: const Text('Select Order'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                DropdownButton<String>(
                                                  value: selectedValue,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedValue = newValue!;
                                                    });
                                                  },
                                                  items: orderOptions,
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  alertBoxContext.pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  String? value =
                                                      await alertBoxContext
                                                          .push(Routes
                                                              .barcodeScanner
                                                              .route);

                                                  await cubit.addBag(
                                                      int.parse(selectedValue),
                                                      value);

                                                  if (alertBoxContext.mounted) {
                                                    alertBoxContext.pop();
                                                  }
                                                },
                                                child: const Text('Scan'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
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
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                                  child:
                                      Text("I want contactless pickup please"),
                                ),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: CustomRoundedButton("No Show")),
                              SizedBox(width: 5),
                              Expanded(child: CustomRoundedButton("Add Notes")),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Order Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 300.0,
                            child: Card(
                              elevation: 10.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    border: TableBorder(
                                      horizontalInside: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 0.7,
                                      ),
                                    ),
                                    columnSpacing: 10.0,
                                    columns: <DataColumn>[
                                      getDataColumn('Order#'),
                                      getDataColumn('Service Type'),
                                      getDataColumn('Bag Count'),
                                      getDataColumn('Expected Count'),
                                    ],
                                    rows: dataRows,
                                  )),
                            ),
                          ),
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
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
