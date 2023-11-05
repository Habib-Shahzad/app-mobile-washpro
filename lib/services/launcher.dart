import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static Future<void> launch(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> openMap(String address) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$address';
    await Launcher.launch(googleUrl);
  }

  static Future<void> openCaller(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    await Launcher.launch(url);
  }
}
