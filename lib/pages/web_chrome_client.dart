import 'package:app_gaitan/pages/web_exception.dart';

class WebChromeClient {
  final void Function(WebException) onUnhandledException;
  WebChromeClient({required this.onUnhandledException});
}
