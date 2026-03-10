import 'dart:math';
import 'package:flutter/material.dart';

class GanjilGenapPrimaScreen extends StatefulWidget {
  const GanjilGenapPrimaScreen({super.key});

  @override
  State<GanjilGenapPrimaScreen> createState() => _GanjilGenapPrimaScreenState();
}

class _GanjilGenapPrimaScreenState extends State<GanjilGenapPrimaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inputController = TextEditingController();
  String _hasilGanjilGenap = '-';
  String _hasilPrima = '-';

  bool isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= sqrt(number); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void _cekAngka() {
    if (_formKey.currentState!.validate()) {
      int? angka = int.tryParse(_inputController.text);
      if (angka != null) {
        setState(() {
          _hasilGanjilGenap = (angka % 2 == 0) ? 'Genap' : 'Ganjil';
          _hasilPrima = isPrime(angka)
              ? 'Bilangan Prima'
              : 'Bukan Bilangan Prima';
        });
      }
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
      appBar: AppBar(title: const Text('Ganjil Genap & Prima')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _inputController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Angka Bulat',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mohon masukkan angka';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Input harus berupa angka bulat valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _cekAngka,
                icon: const Icon(Icons.search),
                label: const Text('Cek Angka', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _buildResultCard(
                      'Status',
                      _hasilGanjilGenap,
                      Icons.compare_arrows,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildResultCard(
                      'Kategori',
                      _hasilPrima,
                      Icons.star,
                      Colors.orange,
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
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: value == '-' ? Colors.grey : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
