import 'package:flutter/material.dart';

class PickupCardProps {
  final String firstLine;
  final String secondLine;
  final String thirdLine;

  PickupCardProps(
      {required this.firstLine,
      required this.secondLine,
      required this.thirdLine});
}

class PickupCard extends StatelessWidget {
  final PickupCardProps customer;
  final void Function()? onTap;

  const PickupCard({super.key, required this.customer, this.onTap});

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
                      customer.firstLine,
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
                  customer.secondLine,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  customer.thirdLine,
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
