import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class PaginatedImages {
  int? count;
  String? next;
  String? previous;
  List<OrderImage>? results;

  PaginatedImages({this.count, this.next, this.previous, this.results});

  factory PaginatedImages.fromJson(Map<String, dynamic> json) =>
      _$PaginatedImagesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedImagesToJson(this);
}

class UploadedImage {
  String? url;
  final XFile? file;

  UploadedImage({
    this.file,
    this.url,
  });
}

@JsonSerializable()
class OrderImage {
  int? id;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  String? image;
  int? order;

  OrderImage({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
    this.order,
  });

  factory OrderImage.fromJson(Map<String, dynamic> json) =>
      _$OrderImageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderImageToJson(this);
}
