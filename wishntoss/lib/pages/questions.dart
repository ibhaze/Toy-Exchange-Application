import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _currentQuestionIndex = 0;

  final List<String> _questions = [
    'What is your favorite color?',
    'What is your preferred mode of transport?',
    'What kind of music do you like?',
    'What is your favorite cuisine?',
  ];

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color backButtonColor = Color(0xFFCC0036);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: backButtonColor,
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        backgroundColor: Colors.transparent, // Set background color to transparent
        elevation: 0, // Remove shadow
        toolbarHeight: 48, // Adjust height to fit the progress indicator
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 6,
                width: 350, // Adjust width as needed
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3), // Rounded corners
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(//this block of code makes 
                    width: 350 * ((_currentQuestionIndex + 1) / _questions.length),
                    decoration: BoxDecoration(
                      color: backButtonColor,
                      borderRadius: BorderRadius.circular(3), // Rounded corners
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _questions[_currentQuestionIndex],
                      style: const TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Here you would put your answer options
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      child: const Text('Next'),
                    ),
                    if (_currentQuestionIndex > 0)
                      ElevatedButton(
                        onPressed: _previousQuestion,
                        child: const Text('Previous'),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionPage(),
  ));
}
