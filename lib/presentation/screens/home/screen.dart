import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:washpro/presentation/widgets/custom_card.dart';
import 'package:washpro/temp.dart';
import 'package:material_symbols_icons/symbols.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle secondaryTitleMedium =
        Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            );

    TextStyle secondaryTitleSmall =
        Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
            bottomRight: Radius.circular(20.0), // Adjust the radius as needed
          ),
        ),
        title: Column(
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
                const SizedBox(width: 2),
                Text(
                  currentUser?.firstName ?? " Valet",
                  style: secondaryTitleMedium,
                ),
              ],
            ),

            const SizedBox(height: 4), // Spacing
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconCard(
                icons: [MdiIcons.account, Symbols.laundry],
                iconSize: 65,
                texts: const ["Pickup", "from", "Customer"],
                elevation: 10,
                iconPadding: 37,
              ),
              const CustomIconCard(
                icons: [Icons.local_laundry_service, Symbols.laundry],
                iconSize: 65,
                texts: ["Drop Off", "at", "Washpro"],
                elevation: 10,
                iconPadding: 47,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconCard(
                icons: [Icons.print_rounded],
                iconSize: 65,
                texts: ["Print", "", "Ticket"],
                elevation: 10,
                iconPadding: 37,
              ),
              CustomIconCard(
                icons: [
                  Icons.shopping_bag_rounded,
                  Symbols.security_update_rounded
                ],
                iconSize: 65,
                texts: ["Update", "bag", "Status"],
                elevation: 10,
                iconPadding: 40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconCard(
                icons: [Icons.local_laundry_service, MdiIcons.bikeFast],
                iconSize: 65,
                texts: const ["Pickup", "from", "Washpro"],
                elevation: 10,
                iconPadding: 47,
              ),
              CustomIconCard(
                icons: [MdiIcons.account, MdiIcons.bikeFast],
                iconSize: 65,
                texts: const ["Delivery", "to", "Customer"],
                elevation: 10,
                iconPadding: 47,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
