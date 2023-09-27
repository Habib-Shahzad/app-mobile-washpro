import 'package:shared_preferences/shared_preferences.dart';
import 'package:washpro/singletons.dart';

enum PreferenceKeys {
  accessToken,
  refreshToken,
}

class SharedPreferencesService {
  static void set(PreferenceKeys key, String value) {
    getIt<SharedPreferences>().setString(key.toString(), value);
  }

  static String? get(PreferenceKeys key) {
    return getIt<SharedPreferences>().getString(key.toString());
  }

  static void remove(PreferenceKeys key) {
    getIt<SharedPreferences>().remove(key.toString());
  }
}
