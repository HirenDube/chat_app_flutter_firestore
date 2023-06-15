import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome to",
              style: TextStyle(fontSize: 30, color: Colors.orange),
            ),
            Image.asset("assets/images/login0.png"),
            CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
            Text(
              "My Chat App",
              style: TextStyle(fontSize: 30, color: Colors.orange),
            )
          ],
        )),
      ),
    );
  }
}
