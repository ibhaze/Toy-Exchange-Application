import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishntoss/widgets/bottom_navigation_bar.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  int _currentQuestionIndex = 0; // Tracks the current question index
  final List<int?> _selectedOptions =
      List<int?>.filled(4, null); // Tracks selected options

  final List<String> _questions = [
    'How would you describe your status?',
    'How many kids do you have?',
    'What are their ages?',
    'Right now I’m looking for...',
  ]; // Questions for the form

  final List<List<String>> _options = [
    ['Single', 'Married'],
    ['None', '1-2', '3-4', 'More than 4'],
    ['0-5', '6-10', '11-15', '16+'],
    ['Stuffed Toys', 'Dolls', 'Educational Toys', 'Other'],
  ]; // Options for each question

  // Method to navigate to the next or previous question
  void _navigateToQuestion(bool isNext) {
    setState(() {
      if (isNext && _currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else if (!isNext && _currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  // Skip action: Can be modified to navigate or complete the form
  void _skipForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form Skipped')),
    );
    // Perform any action here, like navigating to another page or skipping the survey.
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFFCC0036);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: buttonColor,
          ),
          onPressed: () {
            if (_currentQuestionIndex > 0) {
              _navigateToQuestion(false); // Navigate back to previous question
            } else {
              Navigator.of(context).popUntil(
                  (route) => route.isFirst); // Go back to the first screen
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 48,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 10,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width:
                        350 * ((_currentQuestionIndex + 1) / _questions.length),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _questions[
                          _currentQuestionIndex], // Display current question
                      style: GoogleFonts.lexend(fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ..._options[_currentQuestionIndex]
                        .asMap()
                        .entries
                        .map((entry) {
                      int idx = entry.key;
                      String option = entry.value;

                      // Check if this option is selected
                      bool isSelected =
                          _selectedOptions[_currentQuestionIndex] == idx;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // If tapped option is already selected, deselect it
                              if (isSelected) {
                                _selectedOptions[_currentQuestionIndex] = null;
                              } else {
                                _selectedOptions[_currentQuestionIndex] = idx;
                              }
                            });
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFCC0036)
                                  : const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : const Color(0xFFD9D9D9),
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            width: double.infinity,
                            child: Align(
                              alignment: (idx % 2 == 0)
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  option,
                                  style: GoogleFonts.lexend(
                                    fontSize: 18.0,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  textAlign: (idx % 2 == 0)
                                      ? TextAlign.right
                                      : TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          // Underlined "Skip" text
          GestureDetector(
            onTap: _skipForm, // Call the skip method when the text is tapped
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Skip',
                style: GoogleFonts.lexend(
                  fontSize: 16.0,
                  color: buttonColor,
                  decoration: TextDecoration
                      .underline, // Adds underline to the "Skip" text
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentQuestionIndex < _questions.length - 1) {
                  _navigateToQuestion(true); // Go to the next question
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Survey Completed')), // Display completion message
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BottomNavBar()), // navigate to Home page
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
              ),
              child: Text(
                _currentQuestionIndex < _questions.length - 1
                    ? 'Next'
                    : 'Complete',
                style: GoogleFonts.lexend(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Entry point for the application
void main() {
  runApp(const MaterialApp(
    home: QuestionPage(), // Load the QuestionPage as the main screen
  ));
}
