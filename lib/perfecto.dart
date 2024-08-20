import 'package:flutter/material.dart';
import 'package:app_gaitan/pages/buscar_url.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setWebChromeClient(
        WebChromeClient(onUnhandledException: (WebException exception) {
          // Maneja la excepción aquí, por ejemplo, muestra un mensaje de error al usuario
        }),
      )
      ..loadRequest(Uri.parse('http://google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF257bb4),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Color de fondo
          image: DecorationImage(
            image:
                AssetImage('assets/images/background.png'), // Imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/images/logo.png'),
              ),
              //Espacio en blanco
              const SizedBox(height: 20),
              const Text(
                'Tecno Escuela Gaitán...',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              ElevatedButton(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Visitar Sitio',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 73, 73, 73)),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.settings, size: 28, color: Colors.grey),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WebViewWidget(controller: controller)),
                  );
                },
              ),

              ElevatedButton(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Configurar',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 73, 73, 73)),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.settings, size: 28, color: Colors.grey),
                  ],
                ),
                onPressed: () {
                  MaterialPageRoute router = MaterialPageRoute(
                    builder: (context) => const SegundaPage(),
                  );
                  Navigator.of(context).push(router);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebChromeClient {
  WebChromeClient({required this.onUnhandledException});
  final void Function(WebException exception) onUnhandledException;
}

class WebException {}

extension on WebViewController {
  setWebChromeClient(webChromeClient) {}
}
