import 'package:flutter/material.dart';

class Customer {
  final String number;
  final String name;
  final String address;

  Customer({required this.number, required this.name, required this.address});
}

class PickupCard extends StatelessWidget {
  final Customer customer;

  const PickupCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 10.0,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${customer.number}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Icon(Icons.person_outline),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              customer.name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              customer.address,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
