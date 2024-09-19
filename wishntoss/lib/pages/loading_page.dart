import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import for Google Fonts
import 'questions.dart'; // Import the NextPage

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeat animation indefinitely

    // Timer to navigate to NextPage after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const QuestionPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Custom animated loader
            SizedBox(
              width: 100, // Adjust width as needed
              height: 100, // Adjust height as needed
              child: AnimatedLoader(controller: _controller),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/sinterklaas.png', width: 250),
            const SizedBox(height: 20),
            // Header text
            Text(
              'Did you know?',
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Rest of the text with padding and font style
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'The tradition of Sinterklaas goes as far back as the 16th century.',
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.5, // Optional: Adjust letter spacing
                  ),
                ),
                textAlign: TextAlign.center, // Center align text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLoader extends StatelessWidget {
  final AnimationController controller;

  const AnimatedLoader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RoundedLoaderPainter(controller.value),
        );
      },
    );
  }
}

class RoundedLoaderPainter extends CustomPainter {
  final double animationValue;

  RoundedLoaderPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFCC0036)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final double radius = size.width / 2;
    final double center = size.width / 2;

    final Rect rect = Rect.fromCircle(center: Offset(center, center), radius: radius);

    final double startAngle = -0.5 * 3.14;
    final double sweepAngle = 2 * 3.14 * animationValue;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
