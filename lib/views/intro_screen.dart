import 'package:counter_demo/main.dart';
import 'package:counter_demo/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 130,
              child: Text("Contact"),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Welcome to Contact",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            ElevatedButton(
              onPressed: () async {
                prefs.setBool("isIntroOpen", true);
                Navigator.pushNamed(context, homePage);
              },
              child: Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}
