import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'data_kelompok_screen.dart';
import 'kalkulator_screen.dart';
import 'ganjil_genap_prima_screen.dart';
import 'total_angka_screen.dart';
import 'stopwatch_screen.dart';
import 'piramid_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Utama',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        ),
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildMenuCard(
              context,
              'Data Kelompok',
              Icons.group,
              Colors.redAccent,
              const DataKelompokScreen(),
            ),
            _buildMenuCard(
              context,
              'Kalkulator',
              Icons.calculate,
              Colors.blueAccent,
              const KalkulatorScreen(),
            ),
            _buildMenuCard(
              context,
              'Ganjil Genap / Prima',
              Icons.numbers,
              Colors.greenAccent.shade700,
              const GanjilGenapPrimaScreen(),
            ),
            _buildMenuCard(
              context,
              'Total Angka',
              Icons.add_circle,
              Colors.orangeAccent,
              const TotalAngkaScreen(),
            ),
            _buildMenuCard(
              context,
              'Stopwatch',
              Icons.timer,
              Colors.purpleAccent,
              const StopwatchScreen(),
            ),
            _buildMenuCard(
              context,
              'Piramid',
              Icons.change_history,
              Colors.teal,
              const PiramidScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return Card(
      elevation: 6,
      shadowColor: color.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
