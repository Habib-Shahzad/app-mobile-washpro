import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/presentation/widgets/custom_card.dart';
import 'package:washpro/routes/routes.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    push(Routes route) {
      context.go(route.route);
    }

    navigateToCustomersPage() {
      push(Routes.pickUpFromCustomer);
    }

    navigateToDropOff() {
      push(Routes.dropOff);
    }

    navigateToUpdateBag() {
      push(Routes.updateBagScan);
    }

    navigateToPrintScreen() {
      push(Routes.printTicket);
    }

    navigateToWashProScreen() {
      push(Routes.pickUpFromWashPro);
    }

    navigateToDeliveryScreen() {}

    final iconCardPropsList = [
      IconCardProps(
        onTap: navigateToCustomersPage,
        icons: [MdiIcons.account, Symbols.laundry],
        texts: const ["Pickup", "from", "Customer"],
        iconPadding: 37,
      ),
      IconCardProps(
        onTap: navigateToDropOff,
        icons: [Icons.local_laundry_service, Symbols.laundry],
        texts: const ["Drop Off", "at", "Washpro"],
        iconPadding: 47,
      ),
      IconCardProps(
        onTap: navigateToPrintScreen,
        icons: [Icons.print_rounded],
        texts: const ["Print", "", "Ticket"],
        iconPadding: 37,
      ),
      IconCardProps(
        onTap: navigateToUpdateBag,
        icons: [Icons.shopping_bag_rounded, Symbols.security_update_rounded],
        texts: const ["Update", "bag", "Status"],
        iconPadding: 40,
      ),
      IconCardProps(
        onTap: navigateToWashProScreen,
        icons: [Icons.local_laundry_service, MdiIcons.bikeFast],
        texts: const ["Pickup", "from", "Washpro"],
        iconPadding: 47,
      ),
      IconCardProps(
        onTap: navigateToDeliveryScreen,
        icons: [MdiIcons.account, MdiIcons.bikeFast],
        texts: const ["Delivery", "to", "Customer"],
        iconPadding: 47,
      ),
    ];

    TextStyle secondaryTitleMedium =
        Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            );

    TextStyle secondaryTitleSmall =
        Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            );

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit the App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Hello',
                      style: secondaryTitleSmall,
                    ),
                    const SizedBox(width: 1),
                    Text(
                      " Valet,",
                      style: secondaryTitleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(MdiIcons.calendar),
                    const SizedBox(width: 4),
                    Text(
                      "Today",
                      style: secondaryTitleSmall,
                    ),
                    Icon(MdiIcons.chevronDown),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthenticationLogoutRequested());
                      },
                    ),
                    Text(
                      "logout",
                      style: secondaryTitleSmall,
                    ),
                  ],
                )),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CustomIconCard(props: iconCardPropsList[index]);
                  },
                  childCount: iconCardPropsList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
