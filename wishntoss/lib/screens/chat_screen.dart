import 'package:flutter/material.dart';
import 'package:wishntoss/widgets/chatting_list_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            Text("Chat",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ChattingListWidget()
          ],
        ))),
      ),
    );
  }
}
