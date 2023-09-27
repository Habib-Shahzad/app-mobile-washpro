import 'package:dio/dio.dart';
import 'package:washpro/data/models/api/auth/model.dart';
import 'package:washpro/services/preferences.dart';
import 'package:washpro/services/retrofit/client.dart';

Future<String> refreshToken() async {
  String? refreshToken =
      SharedPreferencesService.get(PreferenceKeys.refreshToken);

  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  AuthToken auth = await client.refresh({
    'refresh': refreshToken,
  });

  SharedPreferencesService.set(PreferenceKeys.accessToken, auth.access);
  SharedPreferencesService.set(PreferenceKeys.refreshToken, auth.refresh);

  return auth.access;
}

void addAuthInterceptor(Dio dio) {
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      String? accessToken =
          SharedPreferencesService.get(PreferenceKeys.accessToken);

      // Add the access token to the request header
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    },
    onError: (DioException e, handler) async {
      if (e.response?.statusCode == 401) {
        // If a 401 response is received, refresh the access token
        String newAccessToken = await refreshToken();

        // Update the request header with the new access token
        e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        // Repeat the request with the updated header
        return handler.resolve(await dio.fetch(e.requestOptions));
      }
      return handler.next(e);
    },
  ));
}
