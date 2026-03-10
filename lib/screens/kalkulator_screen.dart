import 'package:flutter/material.dart';

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  State<KalkulatorScreen> createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _angka1Controller = TextEditingController();
  final _angka2Controller = TextEditingController();
  String _hasil = '0';

  void _hitung(String operasi) {
    if (_formKey.currentState!.validate()) {
      double a = double.tryParse(_angka1Controller.text) ?? 0;
      double b = double.tryParse(_angka2Controller.text) ?? 0;
      setState(() {
        if (operasi == '+') _hasil = (a + b).toString();
        if (operasi == '-') _hasil = (a - b).toString();
      });
    }
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Hasil',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _hasil,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _angka1Controller,
                decoration: const InputDecoration(
                  labelText: 'Angka Pertama',
                  prefixIcon: Icon(Icons.looks_one),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan angka pertama';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Input harus berupa angka valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _angka2Controller,
                decoration: const InputDecoration(
                  labelText: 'Angka Kedua',
                  prefixIcon: Icon(Icons.looks_two),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan angka kedua';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Input harus berupa angka valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _hitung('+'),
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _hitung('-'),
                      icon: const Icon(Icons.remove),
                      label: const Text('Kurang'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
