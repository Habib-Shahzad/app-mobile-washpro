import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/business_logic/cubits/pickup_screen/cubit.dart';
import 'package:washpro/data/models/api/order_with_bags/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';

import 'package:washpro/presentation/screens/customer_orders/screen.dart';
import 'package:washpro/presentation/screens/manageOrder/widgets/bag_cards.dart';
import 'package:washpro/presentation/screens/manageOrder/widgets/image_grid.dart';
import 'package:washpro/presentation/screens/manageOrder/widgets/notes_modal.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';

import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/custom_rounded_button.dart';
import 'package:washpro/routes/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:washpro/services/launcher.dart';

class ManageOrderProps {
  final int orderID;
  final String? orderNote;
  final CustomerDetails customer;
  const ManageOrderProps(
      {required this.orderID, required this.customer, this.orderNote});
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
      child: BlocProvider<PickupScreenCubit>(
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

            if (state.savingNotes == LoadingStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Notes saved successfully'),
              ));
            } else if (state.savingNotes == LoadingStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Failed to save notes'),
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

              OrderWithBags? order = state.order;

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
                    onPressed: goBack,
                  ),
                  title: Text(
                    'Pickup',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                        icon: const Icon(Icons.location_pin),
                        onPressed: () {
                          Launcher.openMap(props.customer.address);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () {
                          Launcher.openCaller(props.customer.phone);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: IconButton(
                        icon: const Icon(Icons.chat),
                        onPressed: () {
                          final loading =
                              state.savingNotes == LoadingStatus.loading ||
                                  state.savingNotes == LoadingStatus.loading ||
                                  state.initialLoading == true;
                          if (loading) {
                            return;
                          }
                          final cubit =
                              BlocProvider.of<PickupScreenCubit>(context);

                          final savedOrder = cubit.state.order;

                          showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value:
                                    BlocProvider.of<PickupScreenCubit>(context),
                                child: AddNotesModal(
                                  onSave: (String note) async {
                                    await cubit.saveNotes(props.orderID, note);

                                    if (context.mounted) context.pop();
                                  },
                                  savedNotes: savedOrder?.note,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                body: state.initialLoading == true ||
                        state.pickingUpOrder == LoadingStatus.loading ||
                        order == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
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
                                            int.parse(order.id.toString()),
                                            value);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: CustomRoundedButton("No Show",
                                            onPressed: () {
                                      cubit.updateOrderStatus(
                                          order.id, "no_show");
                                    })),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Bags Scanned',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ),
                                order.bags.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Center(child: Text("No bags")),
                                      )
                                    : BagCards(
                                        bags: order.bags,
                                        onDelete: (String bagID) async {
                                          await cubit.deleteBag(
                                              order.id, bagID);
                                        },
                                      ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Images',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 48,
                                  child: CustomElevatedButton(
                                      buttonText: 'Add Image',
                                      isLoading: false,
                                      iconData: Icons.camera,
                                      onPressed: () async {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        await cubit.addImage();
                                      }),
                                ),
                                const SizedBox(height: 20),
                                ImagesGrid(
                                  orderImages: state.orderImages,
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
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
