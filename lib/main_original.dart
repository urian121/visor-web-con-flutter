import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late WebViewController _controller;
  String _currentUrl = 'http:tecnoescuelagaitan.local';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    await _loadSavedUrl(); // Cargar la URL guardada antes de inicializar el controlador

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setWebChromeClient(
        WebChromeClient(onUnhandledException: (WebException exception) {
          // Maneja la excepción aquí, por ejemplo, muestra un mensaje de error al usuario
        }),
      )
      ..loadRequest(Uri.parse(_currentUrl));
  }

  Future<void> _loadSavedUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUrl = prefs.getString('saved_url');
    if (savedUrl != null && savedUrl.isNotEmpty) {
      setState(() {
        _currentUrl = savedUrl;
      });
    }
  }

  Future<void> _saveUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_url', url);
    setState(() {
      _currentUrl = url;
    });
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
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const Text(
                    'Tecno Escuela Gaitán...',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Visitar Sitio',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewWidget(controller: _controller),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF257bb4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(fontSize: 17),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cambiar URL',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.settings, size: 28, color: Colors.white),
                    ],
                  ),
                  onPressed: () {
                    MaterialPageRoute router = MaterialPageRoute(
                      builder: (context) => SegundaPage(
                        onUrlChanged: (newUrl) async {
                          await _controller.loadRequest(Uri.parse(newUrl));
                          await _saveUrl(newUrl);
                        },
                      ),
                    );
                    Navigator.of(context).push(router);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebChromeClient {
  final void Function(WebException) onUnhandledException;
  WebChromeClient({required this.onUnhandledException});
}

class WebException {
  final String message;
  WebException(this.message);
}

extension on WebViewController {
  setWebChromeClient(webChromeClient) {}
}

class SegundaPage extends StatefulWidget {
  final void Function(String) onUrlChanged;

  const SegundaPage({super.key, required this.onUrlChanged});

  @override
  State<SegundaPage> createState() => _SegundaPageState();
}

class _SegundaPageState extends State<SegundaPage> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tecno Escuela Gaitán',
            style: TextStyle(fontSize: 25, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF257bb4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Cambiar la URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese una URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onUrlChanged(_urlController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Registrar URL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
