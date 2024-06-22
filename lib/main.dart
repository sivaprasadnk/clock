import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analog Clock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClockScreen(),
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  void initState() {
    super.initState();
    // Set the timer to call setState every second
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analog Clock'),
      ),
      body: const Center(
        child: ClockWidget(),
      ),
    );
  }
}

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  void initState() {
    super.initState();
    // Set the timer to call setState every second
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: CustomPaint(
        painter: ClockPainter(),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw the clock circle
    canvas.drawCircle(center, radius, paint);

    // Draw the clock center
    canvas.drawCircle(center, 5, paint..style = PaintingStyle.fill);

    final dateTime = DateTime.now();

    // Draw hour hand
    final hourHandLength = radius * 0.5;
    final hourHandAngle = (dateTime.hour % 12) * 30 + dateTime.minute * 0.5;
    _drawHand(
        canvas, center, hourHandLength, hourHandAngle, paint..strokeWidth = 8);

    // Draw minute hand
    final minuteHandLength = radius * 0.7;
    final minuteHandAngle = dateTime.minute * 6;
    _drawHand(canvas, center, minuteHandLength, minuteHandAngle.toDouble(),
        paint..strokeWidth = 6);

    // Draw second hand
    final secondHandLength = radius * 0.9;
    final secondHandAngle = dateTime.second * 6;
    _drawHand(
        canvas,
        center,
        secondHandLength,
        secondHandAngle.toDouble(),
        paint
          ..strokeWidth = 4
          ..color = Colors.red);
  }

  void _drawHand(
      Canvas canvas, Offset center, double length, double angle, Paint paint) {
    final radian = angle * pi / 180;
    final handX = center.dx + length * cos(radian - pi / 2);
    final handY = center.dy + length * sin(radian - pi / 2);
    canvas.drawLine(center, Offset(handX, handY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
