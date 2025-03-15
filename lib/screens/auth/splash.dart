import 'dart:async';
import 'package:clickcart/utils/constants/colors.dart';
// import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({ super.key });

  @override
  // ignore: library_private_types_in_public_api
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  void setupWorldTime() async {
    
    Timer(const Duration(seconds: 1), () => 
      Navigator.pushReplacementNamed(context, "/main_home")
    );

  }

  @override
  void initState(){
    super.initState();
    setupWorldTime();
  } 

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: IKColors.primary,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splashscreen.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('VERSION 1.0',style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: Colors.white))),
              ),
            ],
          ),
        )
      ),
    );
  }
}