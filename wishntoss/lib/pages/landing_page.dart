import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishntoss/screens/login_screen.dart';
import 'package:wishntoss/screens/signup_screen.dart';
import 'loading_page.dart'; // Import the LoadingPage

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 220.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 40.0),
                child: Image.asset('assets/images/bells.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Text(
                  'WISH \'N TOSS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 47,
                    color: const Color(0xFFCC0036),
                  ),
                ),
              ),
              Text(
                'Swap Toys , Trade Joy',
                style: GoogleFonts.lexend(
                  color: const Color(0xFFCC0036),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const LoadingPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC0036),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC0036),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC0036),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
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
