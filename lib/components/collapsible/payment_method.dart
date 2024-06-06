import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({ super.key });

  @override
  // ignore: library_private_types_in_public_api
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  // Initial height of the container
  double _card1Height = 170.0;
  double _card2Height = 0;
  double _card3Height = 0;
  String _active = "GPay";

  void _toggleHeight(val) {
    setState(() {
      // Toggle between two heights
      _active = val;
      _card1Height = 0;
      _card2Height = 0;
      _card3Height = 0;
      if(val == "GPay"){
        _card1Height = 170.0;
      }
      if(val == "Payment"){
        _card2Height = 150.0;
      }
      if(val == "netbanking"){
        _card3Height = 150.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _toggleHeight('Cash');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        IKSvg.dollor,
                        width: 20,
                        height: 20,
                      ), 
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text('Cash on Delivery(Cash/UPI)',style: Theme.of(context).textTheme.titleMedium)
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).dividerColor,
                        ),
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _active == "Cash" ? IKColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(11)
                          ),
                          height: 11,
                          width: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          )
        ),
        Container(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _toggleHeight('GPay');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        IKSvg.money2,
                        width: 20,
                        height: 20,
                      ), 
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text('Google Pay/Phone Pay/BHIM UPI',style: Theme.of(context).textTheme.titleMedium)
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).dividerColor,
                        ),
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _active == "GPay" ? IKColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(11)
                          ),
                          height: 11,
                          width: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _card1Height,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.all(15),
                  child: ClipPath(
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Link via UPI',
                              labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                              floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5),
                            ),
                            cursorColor: IKColors.primary,
                            style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: ElevatedButton(
                              onPressed: (){}, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                side: const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text('Continue',style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.string(
                              IKSvg.shield,
                              width: 18,
                              height: 18,
                            ), 
                            const SizedBox(width: 5),
                            Text('Your UPI ID Will be encrypted and is 100% safe with us.',style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(fontSize: 13,color: Theme.of(context).textTheme.titleLarge?.color)))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _toggleHeight('Payment');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        IKSvg.folder,
                        width: 20,
                        height: 20,
                      ), 
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text('Payments/Wallet',style: Theme.of(context).textTheme.titleMedium)
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).dividerColor,
                        ),
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _active == "Payment" ? IKColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(11)
                          ),
                          height: 11,
                          width: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _card2Height,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.all(15),
                  child: ClipPath(
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Link Your Wallet',
                              labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                              floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5),
                            ),
                            cursorColor: IKColors.primary,
                            style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: ElevatedButton(
                              onPressed: (){}, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                side: const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text('Continue',style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _toggleHeight('netbanking');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        IKSvg.bank,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text('Netbanking',style: Theme.of(context).textTheme.titleMedium)
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).dividerColor,
                        ),
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _active == "netbanking" ? IKColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(11)
                          ),
                          height: 11,
                          width: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _card3Height,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.all(15),
                  child: ClipPath(
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Account no.',
                              labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                              floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5),
                            ),
                            cursorColor: IKColors.primary,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: ElevatedButton(
                              onPressed: (){}, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).textTheme.bodyMedium?.color,
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                side: const BorderSide(color: Colors.transparent),
                              ),
                              child: const Text('Continue',style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}