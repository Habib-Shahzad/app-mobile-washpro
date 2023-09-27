import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/auth/model.dart';
part 'client.g.dart';

class EmptyResponse {
  fromJson(Map<String, dynamic> json) => EmptyResponse();
}

@RestApi(baseUrl: "http://localhost:8000/api/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("token/")
  Future<AuthToken> signIn(@Body() body);

  @POST("token/refresh/")
  Future<AuthToken> refresh(@Body() body);

  @POST("token/verify/")
  Future<HttpResponse> verify(@Body() body);
}
