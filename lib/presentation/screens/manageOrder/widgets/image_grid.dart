import 'dart:io';
import 'package:flutter/material.dart';
import 'package:washpro/data/models/api/order_image/model.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';

class ImagesGrid extends StatelessWidget {
  final Map<String, UploadedImage> orderImages;
  final Future<void> Function(String imageID) onDelete;
  const ImagesGrid(
      {super.key, required this.orderImages, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (orderImages.isEmpty) {
      return const Center(child: Text('No images to display'));
    }

    final imageKeys = orderImages.keys.toList();

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: imageKeys.length,
      itemBuilder: (context, index) {
        Widget imageWidget = const Center(child: CircularProgressIndicator());
        final key = imageKeys[index];
        final image = orderImages[key]!;

        if (image.url != null) {
          imageWidget = Image.network(
            image.url ?? "",
            fit: BoxFit.cover,
          );
        } else if (image.file != null) {
          imageWidget = Image.file(
            File(image.file!.path),
            fit: BoxFit.cover,
          );
        }

        return GestureDetector(
          onTap: () {
            if (image.url == null) return;
            _openPreviewModal(context, imageWidget, key, onDelete);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: imageWidget,
          ),
        );
      },
    );
  }

  void _openPreviewModal(BuildContext context, Widget imageWidget,
      String imageID, Future<void> Function(String imageID) onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: imageWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await onDelete(imageID);
                    },
                    buttonText: "Delete",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
