import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/business_logic/cubits/manage_order/cubit.dart';
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

class ManageOrderDeliveryProps {
  final int orderID;
  final String? orderNote;
  final CustomerDetails customer;
  const ManageOrderDeliveryProps(
      {required this.orderID, required this.customer, this.orderNote});
}

class ManageOrderDeliveryScreen extends StatelessWidget {
  final ManageOrderDeliveryProps props;
  const ManageOrderDeliveryScreen({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.go(Routes.delivery.route);
      return false;
    }

    displaySnack(LoadingStatus? loading, String success, String failed,
        VoidCallback onClose,
        {VoidCallback? onSuccess}) {
      if (loading == LoadingStatus.success) {
        onClose();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(success),
        ));
        if (onSuccess != null) {
          onSuccess();
        }
      } else if (loading == LoadingStatus.failed) {
        onClose();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(failed),
        ));
      }
    }

    return WillPopScope(
      onWillPop: goBack,
      child: BlocProvider<ManageOrderCubit>(
        create: (context) => ManageOrderCubit(
            customerRepository:
                RepositoryProvider.of<CustomerRepository>(context))
          ..getOrder(props.orderID),
        child: BlocListener<ManageOrderCubit, ManageOrderState>(
          listener: (context, state) {
            final cubit = BlocProvider.of<ManageOrderCubit>(context);

            displaySnack(state.addingBag, 'Bag added successfully',
                'Bag addition failed', cubit.resetAddingBag);

            displaySnack(state.removingBag, 'Bag removed successfully',
                'Bag removal failed', cubit.resetRemovingBag);

            displaySnack(state.savingNotes, 'Notes saved successfully',
                'Failed to save notes', cubit.resetSavingNotes);
            displaySnack(
                state.pickingUpOrder,
                'Order status changed successfully',
                'Failed to change order status',
                cubit.resetPickingUpOrder, onSuccess: () {
              context.go(Routes.delivery.route);
            });
            displaySnack(state.deletingImage, 'Image deleted successfully',
                'Failed to delete image', cubit.resetDeletingImage);
          },
          child: BlocBuilder<ManageOrderCubit, ManageOrderState>(
            builder: (context, state) {
              final cubit = BlocProvider.of<ManageOrderCubit>(context);

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
                    'Deliver',
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
                              BlocProvider.of<ManageOrderCubit>(context);

                          final savedOrder = cubit.state.order;

                          showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value:
                                    BlocProvider.of<ManageOrderCubit>(context),
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
                                          if (state.removingBag ==
                                              LoadingStatus.loading) {
                                            return;
                                          }
                                          await cubit.removeBag(
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
                                state.loadingImages == LoadingStatus.loading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ImagesGrid(
                                        orderImages: state.orderImages,
                                        onDelete: (String imageID) async {
                                          cubit.deleteImage(imageID);
                                        },
                                      ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 48,
                                  child: CustomElevatedButton(
                                      buttonText: 'Deliver',
                                      isLoading: state.pickingUpOrder ==
                                          LoadingStatus.loading,
                                      iconData: MdiIcons.accountCheck,
                                      onPressed: () async {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        await cubit.updateOrderStatus(
                                            order.id, "delivered");
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
