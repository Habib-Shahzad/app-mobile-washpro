import 'package:flutter/material.dart';
import 'package:washpro/data/models/api/bag/model.dart';

class BagCard extends StatelessWidget {
  final Bag bag;
  final void Function(String) onDelete;

  const BagCard({super.key, required this.bag, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  bag.bag_id,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onDelete(bag.bag_id);
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BagCards extends StatelessWidget {
  final List<Bag> bags;
  final void Function(String) onDelete;

  const BagCards({super.key, required this.bags, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bags.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BagCard(bag: bags[index], onDelete: onDelete),
        );
      },
    );
  }
}
