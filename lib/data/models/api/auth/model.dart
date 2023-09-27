import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class AuthToken {
  String access;
  String refresh;

  AuthToken({this.access = '', this.refresh = ''});

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}
