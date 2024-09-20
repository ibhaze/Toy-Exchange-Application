import 'dart:async';  // Import Dart's asynchronous programming library
import 'package:flutter/material.dart';  // Import the Flutter material design library
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package for custom fonts
import 'questions.dart'; // Import the QuestionPage from another file

// Define a StatefulWidget named LoadingPage
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});  // Constructor with an optional key parameter

  @override
  LoadingPageState createState() => LoadingPageState();  // Create the State object
}

// Define the State class for LoadingPage
class LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;  // Declare the animation controller

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,  // Provide the TickerProvider for animation
      duration: const Duration(seconds: 2),  // Set the duration of the animation
    )..repeat();  // Repeat the animation indefinitely

    // Timer to navigate to the QuestionPage after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const QuestionPage()),  // Replace the current page with QuestionPage
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();  // Dispose of the animation controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set the background color of the screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
          crossAxisAlignment: CrossAxisAlignment.center,  // Center the content horizontally
          children: [
            // Custom animated loader widget
            SizedBox(
              width: 100,  // Set width of the loader
              height: 100,  // Set height of the loader
              child: AnimatedLoader(controller: _controller),  // Display the animated loader
            ),
            const SizedBox(height: 20),  // Add space between the loader and image
            Image.asset('assets/images/sinterklaas.png', width: 250),  // Display an image
            const SizedBox(height: 20),  // Add space between the image and text
            // Header text
            Text(
              'Did you know?',
              style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                  fontSize: 30,  // Set font size for the header text
                  fontWeight: FontWeight.w300,  // Set font weight for the header text
                  color: Colors.black,  // Set text color to black
                ),
              ),
            ),
            const SizedBox(height: 10),  // Add space between the header and the following text
            // Rest of the text with padding and font style
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),  // Add horizontal padding
              child: Text(
                'The tradition of Sinterklaas goes as far back as the 16th century.',
                style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                    fontSize: 18,  // Set font size for the body text
                    color: Colors.black,  // Set text color to black
                    fontWeight: FontWeight.w300,  // Set font weight for the body text
                    letterSpacing: 0.5,  // Adjust letter spacing for readability
                  ),
                ),
                textAlign: TextAlign.center,  // Center-align the text
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define a StatelessWidget for the animated loader
class AnimatedLoader extends StatelessWidget {
  final AnimationController controller;  // Animation controller to drive the animation

  const AnimatedLoader({super.key, required this.controller});  // Constructor with required controller parameter

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,  // Link the animation to the controller
      builder: (context, child) {
        return CustomPaint(
          painter: _RoundedLoaderPainter(controller.value),  // Use custom painter to draw the loader
        );
      },
    );
  }
}

// Define a CustomPainter for drawing the animated loader
class _RoundedLoaderPainter extends CustomPainter {
  final double animationValue;  // Value from the animation controller

  _RoundedLoaderPainter(this.animationValue);  // Constructor with animation value parameter

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFCC0036)  // Set the color of the loader
      ..style = PaintingStyle.stroke  // Draw only the border of the loader
      ..strokeWidth = 8.0  // Set the width of the border
      ..strokeCap = StrokeCap.round  // Make the ends of the border rounded
      ..isAntiAlias = true;  // Smooth the edges of the border

    final double radius = size.width / 2;  // Calculate radius of the loader
    final double center = size.width / 2;  // Calculate the center point of the loader

    final Rect rect = Rect.fromCircle(center: Offset(center, center), radius: radius);  // Create a circular path for the loader

    const double startAngle = -0.5 * 3.14;  // Start angle of the arc
    final double sweepAngle = 2 * 3.14 * animationValue;  // Sweep angle of the arc based on animation value

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);  // Draw the arc (loader)
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;  // Repaint the loader when animation value changes
}
