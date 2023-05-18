import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/api/apis.dart';
import 'package:we_chat/screens/auth/login_screen.dart';
import 'package:we_chat/screens/home_screen.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));

      if(APIs.auth.currentUser != null){
        log('\nUser: ${APIs.auth.currentUser}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset('images/chat.png'),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: Text(
              'DEVCLUBDA ISHLAB CHIQARILGAN ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                letterSpacing: .5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
