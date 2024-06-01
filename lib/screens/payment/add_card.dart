import 'package:clickcart/components/payment/payment_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {

  const AddCard({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: const Text('Add Card'),
              titleSpacing: 5,
              centerTitle: true,
            ),
          ),
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: IKColors.primary,
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: IKSizes.container
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 130),
                            child: Container(
                              margin: const EdgeInsets.only(top: 80),
                              padding: const EdgeInsets.only(left: 15,right: 15,top:100),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                              ),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Card Name',
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Card Number',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      keyboardType: TextInputType.number,
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: const UnderlineInputBorder(),
                                              labelText: 'Expiry Date',
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
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: const UnderlineInputBorder(),
                                              labelText: 'CVV',
                                              labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                              floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                              contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                            ),
                                            keyboardType: TextInputType.number,
                                            cursorColor: IKColors.primary,
                                            style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: const PaymentCard(
                                addCard : true,
                                type: "Credit Card", 
                                cardNumber: "**** **** **** 4532", 
                                name: "Roopa Smith", 
                                exp: "10/28", 
                                cvv: "012", 
                                cardImg: IKImages.visa
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: IKColors.primary,
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: IKSizes.container,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: ElevatedButton(
                onPressed: () { 
                  Navigator.pushNamed(context, '/payment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IKColors.secondary,
                  side: const BorderSide(color: IKColors.secondary),
                  foregroundColor: IKColors.title
                ),
                child: const Text('Add Card'),
              ),
            ),
          )
        ],
      ),
    );
  }
}