import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washpro/services/retrofit/client.dart';
import 'package:washpro/services/retrofit/interceptor.dart';

final getIt = GetIt.instance;
final defaultDio = Dio(BaseOptions(contentType: "application/json"));

Future<void> setupSingletons() async {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  await getIt.isReady<SharedPreferences>();

  getIt.registerSingleton<AuthRestClient>(getAuthClient());
  getIt.registerSingleton<RestClient>(RestClient(defaultDio));
}
