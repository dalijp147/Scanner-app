import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "hello guys",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(),
                  TextFormField(),
                  TextFormField(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
