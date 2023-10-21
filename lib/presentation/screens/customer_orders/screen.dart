import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:washpro/data/models/api/order/model.dart';
import 'package:washpro/presentation/screens/pickup/screen.dart';
import 'package:washpro/presentation/widgets/pickup_card.dart';
import 'package:washpro/routes/routes.dart';

class CustomerOrdersScreenProps {
  final List<Order> orders;
  const CustomerOrdersScreenProps({required this.orders});
}

class CustomerOrdersScreen extends StatelessWidget {
  final CustomerOrdersScreenProps props;
  const CustomerOrdersScreen({super.key, required this.props});

  joinBags(List<int> bags) {
    return bags.map((e) => e.toString()).join(' | ');
  }

  String formatDate(String input) {
    DateTime dateTime = DateTime.parse(input);
    String dayOfWeek = DateFormat('EEEE').format(dateTime);
    String day = DateFormat('d').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('y').format(dateTime);

    return '$dayOfWeek - $day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orders = props.orders;

    Future<bool> goBack() async {
      context.pop();
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
            icon: const Icon(Icons.arrow_back),
            onPressed: goBack,
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Pickup Orders",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
        body: Center(
          child: orders.isEmpty
              ? const Text(
                  'No Scheduled Orders!',
                )
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(16.0),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(6.0),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                DefaultCardProps props = DefaultCardProps(
                                  firstLine: joinBags(orders[index].bags),
                                  secondLine: orders[index].order_id,
                                  thirdLine: formatDate(
                                      orders[index].scheduled_pickup),
                                );

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 7.0),
                                  child: DefaultCard(
                                    props: props,
                                    onTap: () => {
                                      context.go(
                                        Routes.manageOrder.route,
                                        extra: ManageOrderProps(
                                          orderID: orders[index].id,
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
      ),
    );
  }
}
