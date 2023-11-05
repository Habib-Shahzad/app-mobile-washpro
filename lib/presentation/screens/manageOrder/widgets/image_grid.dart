import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagesGrid extends StatelessWidget {
  final List<XFile>? orderImages;

  const ImagesGrid({super.key, this.orderImages});

  @override
  Widget build(BuildContext context) {
    if (orderImages == null || orderImages!.isEmpty) {
      return const Center(child: Text('No images to display'));
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: orderImages!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _openPreviewModal(context, orderImages![index]),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.file(
              File(orderImages![index].path),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  void _openPreviewModal(BuildContext context, XFile image) {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                File(image.path),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
