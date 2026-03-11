import 'package:flutter/material.dart';

class DataKelompokScreen extends StatelessWidget {
  const DataKelompokScreen({super.key});

  final List<Map<String, String>> anggota = const [
    {'nama': 'Haidarudzaky Ikhsan', 'nim': '123230122'},
    {'nama': 'Kadek Gary Faldi', 'nim': '123230154'},
    {'nama': 'Lorem Ipsum', 'nim': '123230'},
    {'nama': 'Danendra Pandya Reswara', 'nim': '123230169'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Kelompok TPM IF-C')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: anggota.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  anggota[index]['nama']![0],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              title: Text(
                anggota[index]['nama']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                'NIM: ${anggota[index]['nim']}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          );
        },
      ),
    );
  }
}
