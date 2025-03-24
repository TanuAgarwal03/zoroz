import 'package:clickcart/components/collapsible/payment_method.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {

  const Payment({ super.key });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {


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
              const Expanded(
                child : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      PaymentMethod(),
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
                  child: const Text('Continue', style: TextStyle(color: Colors.white),),
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}