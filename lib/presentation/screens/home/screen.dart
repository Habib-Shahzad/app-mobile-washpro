import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washpro/business_logic/blocs/auth/bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
            // Greeting
            Text(
              'Hello ${currentUser?.firstName ?? "Valet"}',
              style: secondaryTitleMedium,
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
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Adjust the alignment as needed
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          MdiIcons.account,
                          color: const Color(0xFF464747),
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Icon(
                            Symbols.laundry,
                            color: Theme.of(context).colorScheme.primary,
                            size: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        const Icon(
                          Icons.local_laundry_service,
                          color: Color(0xFF464747),
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 37),
                          child: Icon(
                            Symbols.laundry,
                            color: Theme.of(context).colorScheme.primary,
                            size: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
