// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_gaitan/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WebViewApp());

    // Verify that the WebView widget is present.
    expect(find.byType(WebViewWidget), findsOneWidget);
  });
}
