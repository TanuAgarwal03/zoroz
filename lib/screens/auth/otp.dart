import 'package:flutter/material.dart';
import 'package:clickcart/utils/constants/colors.dart';
// import 'package:pinput/pinput.dart';


class Otp extends StatelessWidget {

  const Otp({ super.key });

  @override
  Widget build(BuildContext context){

    // final defaultPinTheme = PinTheme(
    //   width: MediaQuery.of(context).size.width / 6,
    //   height: 48,
    //   textStyle: const TextStyle(
    //     fontSize: 22,
    //     color: Color.fromRGBO(30, 60, 87, 1),
    //   ),
    //   decoration: BoxDecoration(
    //     border: Border(
    //       bottom: BorderSide(width: 2.0, color: Theme.of(context).dividerColor),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP"),
      ),
      body: Container(
        color: IKColors.primary,
        width: double.infinity,
        height: double.infinity,
        child : Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)), // Adjust the radius as needed
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Please enter the OTP sent to',
                        style : Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      Text('+91 897654123',
                        style : Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(color: IKColors.primary)),
                      ),
                      const SizedBox(height: 12),
                      Text('Enter OTP',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),   
                      const SizedBox(height: 10), 
                      // Pinput(
                      //   length: 6,
                      //   defaultPinTheme: defaultPinTheme,
                      //   separatorBuilder: (index) => const SizedBox(width: 8),
                      //   onCompleted: (pin) {
                      //     debugPrint('onCompleted: $pin');
                      //   },
                      //   onChanged: (value) {
                      //     debugPrint('onChanged: $value');
                      //   },
                      //   focusedPinTheme: defaultPinTheme.copyWith(
                      //     decoration: defaultPinTheme.decoration!.copyWith(
                      //       border: const Border(
                      //         bottom: BorderSide(width: 2.0, color: IKColors.primary ),
                      //       ),
                      //     ),
                      //   ),
                      //   submittedPinTheme: defaultPinTheme.copyWith(
                      //     decoration: defaultPinTheme.decoration!.copyWith(
                      //       border: const Border(
                      //         bottom: BorderSide(width: 2.0, color: IKColors.primary ),
                      //       ),
                      //     ),
                      //   ),
                      //   errorPinTheme: defaultPinTheme.copyBorderWith(
                      //     border: Border.all(width: 2.0, color: Colors.redAccent),
                      //   ),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Resend OTP', 
                            style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
                          ),
                        ],
                      )
                    ]
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () { 
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: IKColors.secondary,
                        side: const BorderSide(color: IKColors.secondary),
                        foregroundColor: IKColors.title
                      ),
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
