import 'package:flutter/material.dart';
import 'package:washpro/data/models/api/bag/model.dart';

class BagCard extends StatelessWidget {
  final Bag bag;
  final Future<void> Function(String) onDelete;
  final bool isLoading;
  const BagCard(
      {super.key,
      required this.bag,
      required this.onDelete,
      this.isLoading = false});

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
                  onTap: () async {
                    await onDelete(bag.bag_id);
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.red,
                          ),
                        )
                      : const Icon(
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

class BagCards extends StatefulWidget {
  final List<Bag> bags;
  final Future<void> Function(String) onDelete;

  const BagCards({super.key, required this.bags, required this.onDelete});

  @override
  BagCardsState createState() => BagCardsState();
}

class BagCardsState extends State<BagCards> {
  Map<String, bool> isLoadingMap = {};

  void toggleLoading(String bagId, bool value) {
    setState(() {
      isLoadingMap[bagId] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.bags.length,
      itemBuilder: (context, index) {
        final isLoading = isLoadingMap[widget.bags[index].bag_id] ?? false;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BagCard(
            bag: widget.bags[index],
            onDelete: (String id) async {
              toggleLoading(id, true);
              await widget.onDelete(id);
              toggleLoading(id, false);
            },
            isLoading: isLoading,
          ),
        );
      },
    );
  }
}
