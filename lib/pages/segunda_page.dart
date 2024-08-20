import 'package:flutter/material.dart';

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
