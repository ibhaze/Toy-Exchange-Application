import 'package:flutter/material.dart';
import 'package:wishntoss/services/auth_service.dart';
import 'package:wishntoss/widgets/recommended_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  String _userName = '';
  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

//fech user name
  Future<void> _loadUserName() async {
    Map<String, String?> userDetails =
        await _authService.getCurrentUserDetails();
    setState(() {
      _userName = userDetails['displayName'] ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Image.asset("assets/images/sinterklaas_face.png",
                          width: 48, height: 48),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                          Text(_userName,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  )),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Color(0x66CC0036),
                          fontSize: 16,
                        ),
                        prefixIcon:
                            Icon(Icons.search, color: Color(0xFFCC0036)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0x22CC0036),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text("Stuffed",
                                style: TextStyle(
                                    color: Color(0xFFCC0036),
                                    fontWeight: FontWeight.bold))),
                        SizedBox(width: 10),
                        Container(
                            alignment: Alignment.center,
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0x0000000)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text("Board Games")),
                        SizedBox(width: 10),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0x0000000)),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text("Educational")),
                        SizedBox(width: 10),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0x0000000)),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text("Stuffed")),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text("Recommended",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25))),
                  SizedBox(height: 20),
                  RecommendedWidget(),
                ],
              ),
            )),
      ),
    );
  }
}
