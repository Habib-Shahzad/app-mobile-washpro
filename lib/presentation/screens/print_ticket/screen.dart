import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/blocs/bag/bloc.dart';

import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';
import 'package:washpro/presentation/screens/print_ticket/print_bag_screen.dart';
import 'package:washpro/routes/routes.dart';

class PrintTicketScreen extends StatelessWidget {
  const PrintTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.go(Routes.home.route);
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
        body: BlocProvider<BagBloc>(
          create: (context) =>
              BagBloc(repository: RepositoryProvider.of<BagRepository>(context))
                ..add(const LoadBags(status: BagStatus.dropOff)),
          child: BlocListener<BagBloc, BagState>(
            listener: (context, state) {
              if (state.screenState == ScreenState.loaded) {
                if (state.scanStatus == ScanStatus.matched) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Scan matched'),
                    ),
                  );
                }

                if (state.scanStatus == ScanStatus.invalid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Scan mismatched'),
                    ),
                  );
                }
              } else if (state.screenState == ScreenState.error &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                  ),
                );
              }
            },
            child: BlocBuilder<BagBloc, BagState>(
              builder: (context, state) {
                if (state.screenState == ScreenState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.bags == null || state.bags!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Good Job! No Bags Left',
                    ),
                  );
                }

                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              String? value = await context
                                  .push(Routes.barcodeScanner.route);

                              if (context.mounted && value != null) {
                                BlocProvider.of<BagBloc>(context).add(
                                  BagScanned(
                                    scanResult: value,
                                    updatedStatus: BagStatus.processing,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Tap to Scan',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.bags!.length,
                            itemBuilder: (context, index) {
                              Bag bag = state.bags![index];
                              DefaultCardProps cardProps = DefaultCardProps(
                                firstLine: bag.id.toString(),
                                secondLine: defaultLabeler(bag.bag_type),
                                thirdLine: bag.bag_id,
                              );

                              PrintBagScreenProps props = PrintBagScreenProps(
                                bag: bag,
                              );

                              return DefaultCard(
                                onTap: () async {
                                  await context.push(
                                    Routes.printBag.route,
                                    extra: props,
                                  );
                                  if (context.mounted) {
                                    BlocProvider.of<BagBloc>(context).add(
                                        const LoadBags(
                                            status: BagStatus.dropOff));
                                  }
                                },
                                props: cardProps,
                              );
                            },
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}
