import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0, right: 80, bottom: 40, top: 160
            ),
            child: Image.asset('assets/images/teddy.png'),
          ),
          // Text
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Trade a toy and spread the festive spirit!',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Description
          Text(
            'Start exchanging today',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const Spacer(),
          // Get Started button
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Draggable handle
                      Container(
                        height: 5,
                        width: 40,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // Header Text
                       Padding(
                        padding:  const EdgeInsets.all(16.0),
                        child: Text(
                          'Right now im looking for...',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.fredoka(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                             
                          ),
                        ),
                      ),
                      // Main content
                      const SizedBox(
                        height: 400 - 48, // Adjust height to fit header
                        child: Center(
                          // Add your form or other content here
                        ),
                      ),
                    ],
                  ),
                );
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              isScrollControlled: true,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
