import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/cubits/customer_screen/cubit.dart';
import 'package:washpro/data/models/api/bag/model.dart';
import 'package:washpro/data/models/api/getCustomers/model.dart';
import 'package:washpro/data/repositories/customer/base.dart';
import 'package:washpro/presentation/screens/pick_up/screen.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/routes/routes.dart';
import 'pickup_card.dart';

class PickFromCustomerScreen extends StatelessWidget {
  const PickFromCustomerScreen({super.key});

  joinBags(List<Bag> bags) {
    return bags.map((e) => e.id.toString()).join(' | ');
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> navigateToHome() async {
      context.go(Routes.home.route);
      return false;
    }

    return WillPopScope(
      onWillPop: navigateToHome,
      child: BlocProvider<CustomerScreenCubit>(
        create: (context) => CustomerScreenCubit(
            customerRepository:
                RepositoryProvider.of<CustomerRepository>(context))
          ..getCustomers(),
        child: BlocBuilder<CustomerScreenCubit, CustomerScreenState>(
          builder: (context, state) {
            if (state is Loading || state is Initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is Loaded) {
              CustomersResponse customersResponse = state.customersResponse;

              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: CustomAppBar(
                    goBack: navigateToHome,
                    titleTexts: const [
                      'PickUp',
                      'from',
                      'Customer',
                    ],
                  ),
                ),
                body: Center(
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(16.0),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(6.0),
                                itemCount: customersResponse.count,
                                itemBuilder: (context, index) {
                                  DefaultCardProps props = DefaultCardProps(
                                      thirdLine: customersResponse
                                          .results[index].address,
                                      secondLine:
                                          customersResponse.results[index].name,
                                      firstLine: joinBags(customersResponse
                                              .results[index].bags ??
                                          []));

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 7.0),
                                    child: DefaultCard(
                                      props: props,
                                      onTap: () => {
                                        context.push(
                                          Routes.pickUp.route,
                                          extra: PickUpScreenProps(
                                            customer: customersResponse
                                                .results[index],
                                          ),
                                        ),
                                      },
                                    ),
                                  );
                                },
                              ))),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: Text('Error'),
            );
          },
        ),
      ),
    );
  }
}
