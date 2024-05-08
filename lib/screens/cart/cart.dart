import 'package:clickcart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {

  const Cart({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        titleSpacing: 5,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('12 Items',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)),
          )
        ],
      ),
      body: Column(
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
                    
                  )
                )
              ],
            )
          )
        ],
      ),
    );
  }
}