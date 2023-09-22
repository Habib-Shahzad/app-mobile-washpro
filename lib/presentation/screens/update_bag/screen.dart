import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:washpro/presentation/widgets/custom_app_bar.dart';
import 'package:washpro/routes/routes.dart';

class UpdateBagScreen extends StatelessWidget {
  const UpdateBagScreen({super.key});

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
              'Update',
              'bag',
              'Status',
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(height: 20),
        ),
      ),
    );
  }
}
