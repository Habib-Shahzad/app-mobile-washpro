import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:washpro/data/models/api/auth/model.dart';

import 'ip.dart';
part 'client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("token/")
  Future<AuthToken> signIn(@Body() body);

  @POST("token/refresh/")
  Future<AuthToken> refresh(@Body() body);

  @POST("token/verify/")
  Future<HttpResponse> verify(@Body() body);
}
