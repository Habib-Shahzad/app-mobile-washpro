import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/data/models/bag_detail_row.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';

import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_rounded_button.dart';
import 'package:washpro/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PickUpScreen extends StatelessWidget {
  final Customer customer;
  const PickUpScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    getDataColumn(String text) {
      TextStyle? style = Theme.of(context).textTheme.bodySmall;

      return DataColumn(
        label: Text(
          text,
          style: style,
        ),
      );
    }

    DataRow getDataRow(BagDetailRow bagDetail) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(bagDetail.orderNumber)),
          DataCell(Text(bagDetail.serviceType)),
          DataCell(Text(bagDetail.expected)),
          DataCell(Text(bagDetail.actual)),
          DataCell(Text(bagDetail.variance)),
        ],
      );
    }

    final BagDetailRow row1 = BagDetailRow(
      orderNumber: '1',
      serviceType: 'Practice',
      expected: '8',
      actual: '5',
      variance: '3',
    );

    final BagDetailRow row2 = BagDetailRow(
      orderNumber: '2',
      serviceType: 'Example',
      expected: '10',
      actual: '7',
      variance: '3',
    );

    final List<DataRow> dataRows = [
      getDataRow(row1),
      getDataRow(row2),
    ];

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
      body: SingleChildScrollView(
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
                  height: 20.0,
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
                          columnSpacing: 10.0,
                          columns: <DataColumn>[
                            getDataColumn('Order#'),
                            getDataColumn('ServiceType'),
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
      ),
    );
  }
}
