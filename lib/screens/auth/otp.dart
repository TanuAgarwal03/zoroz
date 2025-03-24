import 'dart:convert';

import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatefulWidget {
  final String phoneNumber; // Passing phone number from previous screen

  const Otp({super.key, required this.phoneNumber});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otpCode = "";
  bool isLoading = false;
  final String hiveBoxName = 'userBox';

  Future<void> verifyLogin() async {
    final url = Uri.parse('https://backend.vansedemo.xyz/api/customer/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phoneNumber,
        }),
      );

      final data = jsonDecode(response.body);
      debugPrint('Login data fetched: $data');

      var box = await Hive.openBox(hiveBoxName);
      await box.put('loginData', data);

      debugPrint('Login data saved in Hive successfully!');

      final storedData = box.get('loginData');
      debugPrint('Retrieved login data from Hive: $storedData');
    } catch (e) {
      debugPrint('Error in verifyLogin: $e');
    }
  }

  Future<void> verifyOtp() async {
    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url =
        Uri.parse('https://backend.vansedemo.xyz/api/customer/verify-phone');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'verificationCode': '111111',
          'phone': widget.phoneNumber,
        }),
      );

      final data = jsonDecode(response.body);
      debugPrint('OTP Verification Response: $data');

      if (response.statusCode == 200 && data['status'] == true) {
        verifyLogin();
        Navigator.pushNamedAndRemoveUntil(
            context, '/main_home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Invalid OTP!')),
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred! Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
        child: Container(
          color: IKColors.primary,
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: IKSizes.container),
            child: AppBar(
              title: const Text("OTP"),
            ),
          ),
        ),
      ),
      body: Container(
        color: IKColors.primary,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Please enter the OTP sent to',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '+91 ${widget.phoneNumber}',
                          style:
                              Theme.of(context).textTheme.headlineMedium?.merge(
                                    const TextStyle(color: IKColors.primary),
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Enter OTP',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 10),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            fieldHeight: 50,
                            fieldWidth: MediaQuery.of(context).size.width >
                                    IKSizes.container
                                ? (IKSizes.container - 80) / 6
                                : (MediaQuery.of(context).size.width - 80) / 6,
                            activeColor: IKColors.primary,
                            selectedColor: IKColors.primary,
                            inactiveColor: Theme.of(context).dividerColor,
                          ),
                          textStyle: Theme.of(context).textTheme.headlineLarge,
                          cursorColor: IKColors.primary,
                          animationDuration: const Duration(milliseconds: 200),
                          keyboardType: TextInputType.number,
                          onCompleted: (value) {
                            debugPrint("Completed: $value");
                            otpCode = value; // Store OTP on completion
                          },
                          onChanged: (value) {
                            otpCode = value; // Update OTP as user types
                          },
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {
                        //         // Optional: You can call resend API here
                        //       },
                        //       child: Text(
                        //         'Resend OTP',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .titleSmall
                        //             ?.merge(
                        //               const TextStyle(color: IKColors.primary),
                        //             ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: isLoading ? null : verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.secondary,
                          side: const BorderSide(color: IKColors.secondary),
                          foregroundColor: IKColors.title,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Continue',
                                style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Otp extends StatelessWidget {

//   const Otp({ super.key });

//   @override
//   Widget build(BuildContext context){

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
//         child: Container(
//           color: IKColors.primary,
//           alignment: Alignment.center,
//           child: Container(
//             constraints: const BoxConstraints(
//               maxWidth: IKSizes.container
//             ),
//             child: AppBar(
//               title: const Text("OTP"),
//             ),
//           ),
//         )
//       ),
//       body: Container(
//         color: IKColors.primary,
//         width: double.infinity,
//         height: double.infinity,
//         alignment: Alignment.topCenter,
//         child : Container(
//           constraints: const BoxConstraints(
//             maxWidth: IKSizes.container,
//           ),
//           child: Card(
//             margin: EdgeInsets.zero,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)), // Adjust the radius as needed
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child : Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text('Please enter the OTP sent to',
//                           style : Theme.of(context).textTheme.headlineMedium,
//                         ),
//                         const SizedBox(height: 6),
//                         Text('+91 897654123',
//                           style : Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(color: IKColors.primary)),
//                         ),
//                         const SizedBox(height: 12),
//                         Text('Enter OTP',
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),   
//                         const SizedBox(height: 10),
//                         PinCodeTextField(
//                           appContext: context,
//                           length: 6,
//                           obscureText: true,
//                           obscuringCharacter: '*',
//                           blinkWhenObscuring: true,
//                           animationType: AnimationType.scale,
//                           pinTheme: PinTheme(
//                             shape: PinCodeFieldShape.underline,
//                             fieldHeight: 50,
//                             fieldWidth: 
//                               MediaQuery.of(context).size.width > IKSizes.container ?
//                                 (IKSizes.container - 80) / 6
//                                 : 
//                                 (MediaQuery.of(context).size.width - 80) / 6,
//                             activeColor: IKColors.primary,
//                             selectedColor: IKColors.primary,
//                             inactiveColor: Theme.of(context).dividerColor,
                            
//                           ),
//                           textStyle: Theme.of(context).textTheme.headlineLarge,
//                           cursorColor: IKColors.primary,
//                           animationDuration: const Duration(milliseconds: 200),
//                           keyboardType: TextInputType.number,
//                           onCompleted: (v) {
//                             debugPrint("Completed");
//                           },
//                           onChanged: (value) {
//                             debugPrint(value); 
//                           },
//                         ), 
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             TextButton(
//                               onPressed: () {},
//                               child: Text('Resend OTP', 
//                               style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
//                             ),
//                           ],
//                         )
//                       ]
//                     ),
//                   )
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child:  Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () { 
//                           Navigator.pushNamed(context, '/main_home');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: IKColors.secondary,
//                           side: const BorderSide(color: IKColors.secondary),
//                           foregroundColor: IKColors.title
//                         ),
//                         child: const Text('Continue'),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
