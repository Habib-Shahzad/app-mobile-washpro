import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateBagScreen extends StatelessWidget {
  const UpdateBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
              bottomRight: Radius.circular(20.0), // Adjust the radius as needed
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: goBack,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'Update',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'bag',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              Text(
                'Status',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
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
