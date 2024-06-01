import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Otp extends StatelessWidget {

  const Otp({ super.key });

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          color: IKColors.primary,
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: const Text("OTP"),
            ),
          ),
        )
      ),
      body: Container(
        color: IKColors.primary,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child : Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Card(
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
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            fieldHeight: 50,
                            fieldWidth: 
                              MediaQuery.of(context).size.width > IKSizes.container ?
                                (IKSizes.container - 80) / 6
                                : 
                                (MediaQuery.of(context).size.width - 80) / 6,
                            activeColor: IKColors.primary,
                            selectedColor: IKColors.primary,
                            inactiveColor: Theme.of(context).dividerColor,
                            
                          ),
                          textStyle: Theme.of(context).textTheme.headlineLarge,
                          cursorColor: IKColors.primary,
                          animationDuration: const Duration(milliseconds: 200),
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
                          onChanged: (value) {
                            debugPrint(value); 
                          },
                        ), 
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
                          Navigator.pushNamed(context, '/main_home');
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
      ),
    );
  }
}
