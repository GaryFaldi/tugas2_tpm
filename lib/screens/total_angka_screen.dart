import 'package:flutter/material.dart';

class TotalAngkaScreen extends StatefulWidget {
  const TotalAngkaScreen({super.key});

  @override
  State<TotalAngkaScreen> createState() => _TotalAngkaScreenState();
}

class _TotalAngkaScreenState extends State<TotalAngkaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();
  int _total = 0;
  bool _hasCalculated = false;

  void _hitungTotal() {
    if (_formKey.currentState!.validate()) {
      String teks = _inputController.text;
      int sum = 0;
      for (int i = 0; i < teks.length; i++) {
        int? num = int.tryParse(teks[i]);
        if (num != null) {
          sum += num;
        }
      }
      setState(() {
        _total = sum;
        _hasCalculated = true;
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jumlah Total Angka')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Contoh: Jika input "123", maka hasil = 1+2+3 = 6',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _inputController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan deretan angka',
                  prefixIcon: Icon(Icons.calculate),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan angka';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Input hanya boleh berisi angka (0-9)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _hitungTotal,
                icon: const Icon(Icons.functions),
                label: const Text(
                  'Hitung Total',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 32),
              if (_hasCalculated) ...[
                const Text(
                  'Hasil Perhitungan:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '$_total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
