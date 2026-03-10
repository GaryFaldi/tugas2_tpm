import 'dart:math';
import 'package:flutter/material.dart';

class PiramidScreen extends StatefulWidget {
  const PiramidScreen({super.key});

  @override
  State<PiramidScreen> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sisiAlasController = TextEditingController();
  final _tinggiController = TextEditingController();
  String _luas = '0.00';
  String _volume = '0.00';

  void _hitungPiramid() {
    if (_formKey.currentState!.validate()) {
      double s = double.tryParse(_sisiAlasController.text) ?? 0;
      double t = double.tryParse(_tinggiController.text) ?? 0;

      if (s > 0 && t > 0) {
        double volumePiramid = (1 / 3) * (s * s) * t;
        double tinggiSegitiga = sqrt(pow((s / 2), 2) + pow(t, 2));
        double luasPermukaan = (s * s) + (4 * (0.5 * s * tinggiSegitiga));

        setState(() {
          _volume = volumePiramid.toStringAsFixed(2);
          _luas = luasPermukaan.toStringAsFixed(2);
        });
      }
    }
  }

  @override
  void dispose() {
    _sisiAlasController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Luas & Volume Piramid')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.change_history,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Hitungan berdasarkan Piramida Alas Persegi (Square Pyramid)',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _sisiAlasController,
                decoration: const InputDecoration(
                  labelText: 'Panjang Sisi Alas (s)',
                  prefixIcon: Icon(Icons.straighten),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sisi alas tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Input harus angka lebih besar dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tinggiController,
                decoration: const InputDecoration(
                  labelText: 'Tinggi Piramida (t)',
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tinggi tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Input harus angka lebih besar dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _hitungPiramid,
                icon: const Icon(Icons.calculate),
                label: const Text('Hitung', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _buildResultCard(
                      'Volume',
                      _volume,
                      Icons.view_in_ar,
                      Colors.teal,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildResultCard(
                      'Luas Permukaan',
                      _luas,
                      Icons.layers,
                      Colors.deepPurple,
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

  Widget _buildResultCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: value == '0.00' ? Colors.grey : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
