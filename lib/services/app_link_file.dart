import 'package:app_links/app_links.dart';

class AppLinkUri {
  final appLinks = AppLinks(); // AppLinks is singleton
  init() {
// Subscribe to all events (initial link and further)
    final sub = appLinks.uriLinkStream.listen((uri) {
      print("dsaldklaskld ${uri.data} ${uri.data}");

      // Do something (navigation, ...)
    });
  }
}
