import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _start() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {});
    });
  }

  void _stop() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _reset() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatTime() {
    final ms = _stopwatch.elapsedMilliseconds;
    int hundreds = (ms / 10).truncate() % 100;
    int seconds = (ms / 1000).truncate() % 60;
    int minutes = (ms / (1000 * 60)).truncate();
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundreds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 10,
                  ),
                ],
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  width: 8,
                ),
              ),
              child: Text(
                _formatTime(),
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircularButton(
                  icon: Icons.play_arrow_rounded,
                  color: Colors.green,
                  onPressed: _stopwatch.isRunning ? null : _start,
                  tooltip: 'Start',
                ),
                const SizedBox(width: 24),
                _buildCircularButton(
                  icon: Icons.pause_rounded,
                  color: Colors.red,
                  onPressed: _stopwatch.isRunning ? _stop : null,
                  tooltip: 'Stop',
                ),
                const SizedBox(width: 24),
                _buildCircularButton(
                  icon: Icons.refresh_rounded,
                  color: Colors.blueGrey,
                  onPressed: _reset,
                  tooltip: 'Reset',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: onPressed == null ? Colors.grey.shade300 : color,
        shape: const CircleBorder(),
        elevation: onPressed == null ? 0 : 4,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              icon,
              size: 32,
              color: onPressed == null ? Colors.grey.shade500 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
