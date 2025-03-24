import 'dart:convert';

import 'package:clickcart/screens/auth/otp.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String phoneNumber = '';
  bool isLoading = false;

  Future<void> sendVerification() async {
    if (phoneNumber.isEmpty || phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid 10-digit phone number.')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://backend.vansedemo.xyz/api/customer/verificationSend');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phoneNumber,
          'isLoginVerification': true,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otp(phoneNumber: phoneNumber),
          ),
        );
      } else if (data['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'User with the entered phone number does not exist!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.redAccent,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('An error occurred! Please try again.'),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.redAccent,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
          duration: const Duration(seconds: 5),
        ),
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
                title: const Text("Login"),
              ),
            ),
          )),
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
                  topRight:
                      Radius.circular(10.0)), // Adjust the radius as needed
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
                              'Login to Zoroz!',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Enter Mobile number',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // TextField(
                            //   maxLength: 10,
                            //   decoration: InputDecoration(
                            //       hintText: 'Phone number',
                            //       counterText: "",
                            //       contentPadding: const EdgeInsets.all(18),
                            //       prefixIcon: SizedBox(
                            //         height: 50,
                            //         width: 125,
                            //         child: CountryCodePicker(
                            //           dialogSize: Size(
                            //               IKSizes.container - 40,
                            //               MediaQuery.of(context).size.height -
                            //                   200),
                            //           boxDecoration: BoxDecoration(
                            //               color: Theme.of(context).cardColor,
                            //               borderRadius:
                            //                   BorderRadius.circular(10)),
                            //           onChanged: print,
                            //           showFlagMain: true,
                            //           initialSelection: 'IN',
                            //           alignLeft: true,
                            //           padding: const EdgeInsets.all(0),
                            //         ),
                            //       ),
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: Theme.of(context).dividerColor,
                            //             width: 2.0),
                            //       ),
                            //       focusedBorder: const UnderlineInputBorder(
                            //           borderSide: BorderSide(
                            //               color: IKColors.primary,
                            //               width: 2.0))),
                            //   keyboardType: TextInputType.phone,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineMedium
                            //       ?.merge(const TextStyle(
                            //           fontWeight: FontWeight.w400)),
                            // ),
                            TextField(
                              maxLength: 10,
                              onChanged: (value) {
                                setState(() {
                                  phoneNumber = value.trim();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Phone number',
                                counterText: "",
                                contentPadding: const EdgeInsets.all(18),
                                prefixIcon: SizedBox(
                                  height: 50,
                                  width: 125,
                                  child: CountryCodePicker(
                                    dialogSize: Size(
                                        IKSizes.container - 40,
                                        MediaQuery.of(context).size.height -
                                            200),
                                    boxDecoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onChanged: print,
                                    showFlagMain: true,
                                    initialSelection: 'IN',
                                    alignLeft: true,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).dividerColor,
                                      width: 2.0),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: IKColors.primary, width: 2.0)),
                              ),
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.merge(const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),

                            const SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                text: "By continuing, you agree to Zoroz",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.merge(const TextStyle(
                                        fontWeight: FontWeight.w400)),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: ' Terms of Use',
                                      style: TextStyle(
                                          color: IKColors.primary,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(text: ' and'),
                                  TextSpan(
                                      text: ' Privacy Policy.',
                                      style: TextStyle(
                                          color: IKColors.primary,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )
                          ]),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "New to Zoroz?",
                          style: Theme.of(context).textTheme.titleMedium?.merge(
                              const TextStyle(fontWeight: FontWeight.w400)),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Create an account',
                                style: const TextStyle(
                                    color: IKColors.primary,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(context, '/signup');
                                  }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          sendVerification();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: IKColors.secondary,
                            side: const BorderSide(color: IKColors.secondary),
                            foregroundColor: IKColors.title),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
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
