import 'package:clickcart/utils/constants/sizes.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/utils/constants/colors.dart';


class SignUp extends StatelessWidget {

  const SignUp({ super.key });
  
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
              title: const Text("Create Account"),
              actions: [
                TextButton(
                  onPressed: () { 
                    Navigator.pushNamed(context, '/main_home');
                  },
                  child: Text('Skip',
                      style: Theme.of(context).textTheme.bodyLarge?.merge(const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        )
                      )
                  ),
                )
              ],
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
                  child : SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Fresh arrival, ready to explore?',
                            style : Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 6),
                          Text('Register using your phone number to begin',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 15),
                          Text('Your Name',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Username',
                              contentPadding: const EdgeInsets.all(15),
                              prefixIcon: const Icon(Icons.person,color: IKColors.primary),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).dividerColor,width: 2.0),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: IKColors.primary,width: 2.0)
                              )
                            ),
                            style: Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Enter Mobile number',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text('Use Email Id',
                                style: Theme.of(context).textTheme.labelSmall?.merge(const TextStyle(color: IKColors.primary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              contentPadding: const EdgeInsets.all(18),
                              prefixIcon: SizedBox(
                                height: 50,
                                width: 125,
                                child: CountryCodePicker(
                                  dialogSize:Size(IKSizes.container - 40, MediaQuery.of(context).size.height - 200),
                                  boxDecoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  onChanged: print,
                                  showFlagMain: true,
                                  initialSelection: 'IN',
                                  alignLeft: true,
                                  padding: const EdgeInsets.all(0),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).dividerColor,width: 2.0),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: IKColors.primary,width: 2.0)
                              )
                            ),
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(height: 12),
                          RichText(
                            text: TextSpan(
                              text: "By continuing, you agree to ClickCart's",
                              style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                              children: const <TextSpan>[
                                TextSpan(text: ' Terms of Use',style: TextStyle(color: IKColors.primary,fontWeight: FontWeight.w600)),
                                TextSpan(text: ' and'),
                                TextSpan(text: ' Privacy Policy.',style: TextStyle(color: IKColors.primary,fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )
                        ]
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Existing User?",
                          style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(color: IKColors.primary,fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushNamed(context, '/signin');
                              }
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
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
