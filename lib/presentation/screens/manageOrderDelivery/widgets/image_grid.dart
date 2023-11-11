import 'dart:io';
import 'package:flutter/material.dart';
import 'package:washpro/data/models/api/order_image/model.dart';
import 'package:washpro/presentation/widgets/custom_elevated_button.dart';

class ImageItem extends StatefulWidget {
  final String imageID;
  final UploadedImage image;
  final Future<void> Function(String imageID) onDelete;
  const ImageItem(
      {super.key,
      required this.image,
      required this.onDelete,
      required this.imageID});

  @override
  ImageItemState createState() => ImageItemState();
}

class ImageItemState extends State<ImageItem> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Image? networkImage;
    Image? localImage;

    final key = widget.imageID;
    final image = widget.image;

    if (image.url != null) {
      networkImage = Image.network(
        image.url ?? "",
        fit: BoxFit.cover,
      );
    } else if (image.file != null) {
      localImage = Image.file(
        File(image.file!.path),
        fit: BoxFit.cover,
      );
    }

    networkImage?.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
      ),
    );

    return GestureDetector(
      onTap: () {
        if (networkImage == null || isLoading == true) return;
        _openPreviewModal(context, networkImage, key, widget.onDelete);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : networkImage ?? localImage,
      ),
    );
  }

  void _openPreviewModal(BuildContext context, Image imageWidget,
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
        final imageID = imageKeys[index];
        final image = orderImages[imageID]!;
        return ImageItem(
          imageID: imageID,
          image: image,
          onDelete: onDelete,
        );
      },
    );
  }
}
