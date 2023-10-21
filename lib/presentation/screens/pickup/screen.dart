import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/business_logic/cubits/pickup_screen/cubit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/models/bag_detail_row.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';

import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_rounded_button.dart';
import 'package:washpro/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OrderDetailTable extends StatelessWidget {
  final String expected;
  final String actual;
  final String variance;

  const OrderDetailTable({
    Key? key,
    required this.expected,
    required this.actual,
    required this.variance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataColumn getDataColumn(String text) {
      TextStyle? style = Theme.of(context).textTheme.bodySmall;
      return DataColumn(
        label: Text(
          text,
          style: style,
        ),
        numeric: false,
      );
    }

    return Center(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
        child: DataTable(
          dividerThickness: 0.7,
          columns: <DataColumn>[
            getDataColumn('Expected'),
            getDataColumn('Actual'),
            getDataColumn('Variance'),
          ],
          rows: [
            DataRow(
              cells: <DataCell>[
                DataCell(Center(child: Text(expected))),
                DataCell(Center(child: Text(actual))),
                DataCell(Center(child: Text(variance))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BagDetailTable extends StatelessWidget {
  final List<BagDetailRow> rows;

  const BagDetailTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    DataColumn getDataColumn(String text) {
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
      return DataCell(Center(child: Text(text)));
    }

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24.0,
          dividerThickness: 0.7,
          columns: [
            getDataColumn('Bag#'),
            getDataColumn('Service Type'),
            getDataColumn('Weight'),
            getDataColumn('Item Count'),
          ],
          rows: rows.map((row) {
            return DataRow(
              cells: [
                getDataCell(row.bagID),
                getDataCell(row.serviceType),
                getDataCell(row.weight),
                getDataCell(row.itemCount),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ManageOrderProps {
  final int orderID;
  const ManageOrderProps({required this.orderID});
}

class ManageOrderScreen extends StatelessWidget {
  final ManageOrderProps props;
  const ManageOrderScreen({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.go(Routes.pickFromCustomer.route);
      return false;
    }

    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
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
            ..getOrder(props.orderID),
          child: BlocListener<PickupScreenCubit, PickupScreenState>(
            listener: (context, state) {
              if (state.addingBag == LoadingStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Bag added successfully'),
                ));
              } else if (state.addingBag == LoadingStatus.failed) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Bag addition failed'),
                ));
              }

              if (state.pickingUpOrder == LoadingStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Order status changed successfully'),
                ));
                context.go(Routes.home.route);
              } else if (state.pickingUpOrder == LoadingStatus.failed) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Failed to change order status'),
                ));
              }
            },
            child: BlocBuilder<PickupScreenCubit, PickupScreenState>(
              builder: (context, state) {
                final cubit = BlocProvider.of<PickupScreenCubit>(context);

                if (state.initialLoading == true ||
                    state.pickingUpOrder == LoadingStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.initialLoading == false && state.order != null) {
                  OrderWithBags order = state.order!;

                  List<BagDetailRow> rows = [];

                  for (Bag bag in order.bags) {
                    rows.add(BagDetailRow(
                      bagID: bag.id.toString(),
                      serviceType: bag.bag_type,
                      weight: bag.weight != null ? bag.weight.toString() : '-',
                      itemCount: bag.item_count != null
                          ? bag.item_count.toString()
                          : '-',
                    ));
                  }

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
                                firstLine: order.customer.customer_id,
                                secondLine: order.customer.name,
                                thirdLine: order.customer.address,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            OrderDetailTable(
                              expected: order.expected_bag_count != null
                                  ? order.expected_bag_count.toString()
                                  : '-',
                              actual: order.bags.length.toString(),
                              variance: order.expected_bag_count != null
                                  ? (order.expected_bag_count! -
                                          order.bags.length)
                                      .toString()
                                  : '-',
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
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    String? value = await context
                                        .push(Routes.barcodeScanner.route);

                                    await cubit.addBag(
                                        int.parse(order.id.toString()), value);
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
                                    child: Text(
                                        "I want contactless pickup please"),
                                  ),
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: CustomRoundedButton("No Show",
                                        onPressed: () {
                                  cubit.updateOrderStatus(order.id, "no_show");
                                })),
                                const SizedBox(width: 5),
                                // Expanded(
                                //     child: CustomRoundedButton(
                                //   "Add Notes",
                                //   onPressed: () {},
                                // )),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Bag Details',
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
                              child: BagDetailTable(rows: rows),
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
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    await cubit.updateOrderStatus(
                                        order.id, "processing");
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
      ),
    );
  }
}
