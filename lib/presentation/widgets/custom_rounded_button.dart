import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;

  const CustomRoundedButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(40.0),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.secondary)),
    );
  }
}
