import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishntoss/pages/home_page.dart';
 
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Logo
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,right: 80, bottom: 40, top:160
            ),
            child: Image.asset('assets/images/teddy.png'),
          ),
          //Give a toy, get a toy, and make festive wishes come true!
           Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Trade a toy and spread the festive spirit!',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,  
              ),
              
            ),
          ),
          const SizedBox(height: 24,),
          //Start exchanging today
          Text(
            'Start exchanging today',
            style: TextStyle(color: Colors.grey.shade600),),
          const Spacer(

          ),
          //get started button
          GestureDetector(
          onTap:() => Navigator.pushReplacement(context,MaterialPageRoute(
            builder: (context)
            {
              return const HomePage();
            }) ,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12)
              ),
              padding:const EdgeInsets.all(24),
              child: const Text(
                'Get Started',
              )
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}