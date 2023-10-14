import 'package:flutter/material.dart';

class DefaultCardProps {
  final String firstLine;
  final String secondLine;
  final String thirdLine;

  DefaultCardProps(
      {required this.firstLine,
      required this.secondLine,
      required this.thirdLine});
}

class DefaultCard extends StatelessWidget {
  final DefaultCardProps props;
  final void Function()? onTap;

  const DefaultCard({super.key, required this.props, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      props.firstLine,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const Icon(Icons.person_outline),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  props.secondLine,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  props.thirdLine,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
