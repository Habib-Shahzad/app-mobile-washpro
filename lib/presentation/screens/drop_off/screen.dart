import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/blocs/bag/bloc.dart';

import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/routes/routes.dart';

class DropOffScreen extends StatelessWidget {
  const DropOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> goBack() async {
      context.go(Routes.home.route);
      return false;
    }

    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            goBack: goBack,
            titleTexts: const [
              'DropOff',
              'at',
              'WashPro',
            ],
          ),
        ),
        body: BlocProvider<BagBloc>(
          create: (context) =>
              BagBloc(repository: RepositoryProvider.of<BagRepository>(context))
                ..add(const LoadBags(status: BagStatus.pickedUp)),
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

                List<DefaultCardProps> propList = state.bags!
                    .map((Bag e) => DefaultCardProps(
                          firstLine: e.id.toString(),
                          secondLine: defaultLabeler(e.bag_type),
                          thirdLine: e.bag_id,
                        ))
                    .toList();
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        CustomElevatedButton(
                            buttonText: 'Scan Bag',
                            isLoading: false,
                            iconData: Icons.camera,
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              String? value = await context
                                  .push(Routes.barcodeScanner.route);

                              if (context.mounted && value != null) {
                                BlocProvider.of<BagBloc>(context).add(
                                  BagScanned(
                                    scanResult: value,
                                    updatedStatus: BagStatus.dropOff,
                                  ),
                                );
                              }
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: propList.length,
                            itemBuilder: (context, index) {
                              return DefaultCard(
                                props: propList[index],
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
