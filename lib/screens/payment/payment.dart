import 'package:clickcart/components/collapsible/payment_method.dart';
import 'package:clickcart/components/payment/payment_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {

  const Payment({ super.key });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  String _selectedCard = "1";

  final List<Map<String, String>> cards = [
    {
      'id' : "1",
      'card_img' : IKImages.visa,
      'type' : 'Credit Card',
      'card_number': '**** **** **** 4532', 
      'name' : 'Roopa Smith',
      'exp' : '10/28',
      'cvv' : '012',
    },
    {
      'id' : "2",
      'type' : 'Debit Card',
      'card_img' : IKImages.mastercard,
      'card_number': '**** **** **** 4532', 
      'name' : 'Roopa Smith',
      'exp' : '10/28',
      'cvv' : '012',
    },
    {
      'id' : "3",
      'card_img' : IKImages.visa,
      'type' : 'Credit Card',
      'card_number': '**** **** **** 4532', 
      'name' : 'Roopa Smith',
      'exp' : '10/28',
      'cvv' : '012',
    },
  ];

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
              title: const Text('Payment'),
              titleSpacing: 5,
              centerTitle: true,
            ),
          ),
        )
      ),
      body:  Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                child : Row(
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: IKColors.primary,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: const Text('1',textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500)),
                    ),
                    Text('Cart',style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: IKColors.primary))
                        ),
                      )
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: IKColors.primary,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: const Text('2',textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500)),
                    ),
                    Text('Address',style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: IKColors.primary))
                        ),
                      )
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: IKColors.primary,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: const Text('3',textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500)),
                    ),
                    Text('Payment',style: Theme.of(context).textTheme.titleMedium),
                  ],
                )
              ),
              Expanded(
                child : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        color: Theme.of(context).cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 15,top: 5,bottom: 5,right: 5),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor)) 
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text('Credit/Debit Card',style: Theme.of(context).textTheme.headlineMedium),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/add_card');
                                    }, 
                                    child: Row(
                                      children: [
                                        const Icon(Icons.add_circle_outline,color:IKColors.primary,size: 16),
                                        const SizedBox(width: 3),
                                        Text('Add Card',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary))),
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: cards.map((item) {
                                    return Container(
                                      width: 277,
                                      margin: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: (){ 
                                          setState(() {
                                            _selectedCard = item['id']!;
                                          });
                                        },
                                        child : PaymentCard(
                                          type: item['type']!,
                                          cardImg: item['card_img']!,
                                          cardNumber: item['card_number']!,
                                          name: item['name']!,
                                          exp: item['exp']!,
                                          cvv: item['cvv']!,
                                          id: item['id']!,
                                          activeCard : _selectedCard,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const PaymentMethod(),
          
                    ],
                  )
                )
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () { 
                    Navigator.pushNamed(context, '/checkout');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IKColors.secondary,
                    side: const BorderSide(color: IKColors.secondary),
                    foregroundColor: IKColors.title
                  ),
                  child: const Text('Continue'),
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}