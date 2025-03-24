// import 'dart:async';
// import 'package:clickcart/utils/constants/colors.dart';
// // import 'package:clickcart/utils/constants/images.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// class Splash extends StatefulWidget {
//   const Splash({ super.key });

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
  
//   void setupWorldTime() async {
    
//     Timer(const Duration(seconds: 1), () => 
//       Navigator.pushReplacementNamed(context, "/main_home")
//     );

//   }

//   @override
//   void initState(){
//     super.initState();
//     fetchLogindetails();
//     setupWorldTime();
//   } 

//     void fetchLogindetails() async {
//     var box = await Hive.openBox('userBox');
//     final loginData = box.get('loginData');

//     if (loginData != null) {
//       print('Phone: ${loginData['phone']}');
//       print('Token (if available): ${loginData['token']}');
//       print('Name : ${loginData['name']}');
//       print('Email : ${loginData['email']}');
//       print('Id : ${loginData['_id']}');
//     }
//   }


//   @override
//   Widget build(BuildContext context) {


//     return Scaffold(
//       backgroundColor: IKColors.primary,
//       body: SafeArea(
//         child: Container(
//           width: double.maxFinite,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/splashscreen.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text('VERSION 1.0',style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: Colors.white))),
//               ),
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    checkLoginAndRedirect();
  }

  void checkLoginAndRedirect() async {
    var box = await Hive.openBox('userBox');
    final loginData = box.get('loginData');

    // Optional: Debug prints
    if (loginData != null) {
      print('User found: ${loginData['phone']}');
    } else {
      print('No user found. Redirecting to Login.');
    }

    // Add a delay for the splash screen (optional, adjust as needed)
    Timer(const Duration(seconds: 1), () {
      if (loginData == null) {
        Navigator.pushReplacementNamed(context, "/signin");
      } else {
        Navigator.pushReplacementNamed(context, "/main_home");
      }
    });
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
                child: Text(
                  'VERSION 1.0',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.merge(const TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
