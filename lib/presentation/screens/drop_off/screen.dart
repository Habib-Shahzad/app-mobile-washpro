import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/cubits/dropoff_screen/cubit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/repositories/bag/base.dart';
import 'package:washpro/presentation/screens/pick_from_customer/pickup_card.dart';
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
        body: BlocProvider<DropOffScreenCubit>(
          create: (context) => DropOffScreenCubit(
              bagRepository: RepositoryProvider.of<BagRepository>(context))
            ..getPickedUpBags(),
          child: BlocBuilder<DropOffScreenCubit, DropOffScreenState>(
            builder: (context, state) {
              if (state is Loading || state is Initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is Loaded) {
                List<DefaultCardProps> propList = state.bagList
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
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              String value = await context
                                  .push(Routes.barcodeScanner.route) as String;

                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(value),
                                    );
                                  });
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
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
