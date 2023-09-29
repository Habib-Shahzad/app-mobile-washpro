import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/business_logic/cubits/pickup_screen/cubit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/customer/model.dart';
import 'package:washpro/data/models/api/getOrders/model.dart';
import 'package:washpro/data/models/bag_detail_row.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';

import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_rounded_button.dart';
import 'package:washpro/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PickUpScreenProps {
  final Customer customer;
  const PickUpScreenProps({required this.customer});
}

class PickUpScreen extends StatelessWidget {
  final PickUpScreenProps props;
  const PickUpScreen({super.key, required this.props});

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
          getDataCell(bagDetail.expected),
          getDataCell(bagDetail.actual),
          getDataCell(bagDetail.variance),
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
            context.go(Routes.pickUpFromCustomer.route);
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
        child: BlocBuilder<PickupScreenCubit, PickupScreenState>(
          builder: (context, state) {
            if (state is Initial || state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is Loaded) {
              List<Order> orders = state.orderList;

              List<BagDetailRow> rows = [];

              for (Order order in orders) {
                for (Bag bag in order.bags) {
                  rows.add(BagDetailRow(
                    orderNumber: order.id.toString(),
                    serviceType: bag.bag_type,
                    expected: order.expected_bag_count.toString(),
                    actual: '0',
                    variance: '0',
                  ));
                }
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 0.7,
                                    ),
                                  ),
                                  columnSpacing: 10.0,
                                  columns: <DataColumn>[
                                    getDataColumn('Order#'),
                                    getDataColumn('Service Type'),
                                    getDataColumn('Expected'),
                                    getDataColumn('Actual'),
                                    getDataColumn('Variance'),
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
    );
  }
}
