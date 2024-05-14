import 'package:clickcart/components/product/product_cart.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {

  Cart({ super.key });

  final List<Map<String, String>> cartItems = [
    {
      'id' : "1",
      'category' : 'Apple',
      'title': 'APPLE iPhone 14 (Blue, 128 GB)', 
      'image': IKImages.product1,
      'price' : '150',
      'old-price' : '170',
      'offer' : '70% OFF',
      'returnday' : '14',
      'count' : '14',
      'reviews' : '260',
    },
    {
      'id' : "2",
      'category' : 'Apple',
      'title': 'Polka dot wrap blouse', 
      'image': IKImages.product2,
      'price' : '135',
      'old-price' : '152',
      'offer' : '30% OFF',
      'returnday' : '14',
      'count' : '10',
      'reviews' : '240',
    },
    {
      'id' : "3",
      'category' : 'Apple',
      'title': 'Cuisinart Compact 2-Slice', 
      'image': IKImages.product3,
      'price' : '125',
      'old-price' : '164',
      'offer' : '45% OFF',
      'returnday' : '14',
      'count' : '8',
      'reviews' : '180',
    },
    {
      'id' : "4",
      'category' : 'Apple',
      'title': 'LG TurboWash Washing', 
      'image': IKImages.product4,
      'price' : '100',
      'old-price' : '112',
      'offer' : '15% OFF',
      'returnday' : '14',
      'count' : '7',
      'reviews' : '150',
    },
    {
      'id' : "5",
      'category' : 'Apple',
      'title': 'KitchenAid 9-Cup Food', 
      'image': IKImages.product5,
      'price' : '15',
      'old-price' : '20',
      'offer' : '25% OFF',
      'returnday' : '14',
      'count' : '4',
      'reviews' : '180',
    },
  ];

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
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2, color: Theme.of(context).dividerColor))
                    ),
                  )
                ),
                Container(
                  height: 18,
                  width: 18,
                  padding: const EdgeInsets.only(bottom: 0),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(9)
                  ),
                  child:  Text('2',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleSmall),
                ),
                Text('Address',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontWeight: FontWeight.w500))),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2, color: Theme.of(context).dividerColor))
                    ),
                  )
                ),
                Container(
                  height: 18,
                  width: 18,
                  padding: const EdgeInsets.only(bottom: 0),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(9)
                  ),
                  child: Text('3',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleSmall),
                ),
                Text('Payment',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontWeight: FontWeight.w500))),
              ],
            )
          )
          ,
          Expanded(
            child : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: const Color(0xFFC5F4FF),
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'You’re saving ',
                            style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w400)),
                            children: const <InlineSpan>[
                              TextSpan(
                                text: '\$5,565',
                                style: TextStyle(color: Color(0xFF07A3C5),fontWeight: FontWeight.w600)
                              ),
                              TextSpan(
                                text: ' on this time',
                              )
                            ]
                          )
                        ),
                      ],
                    ),
                  )
                  ,
                  Column(
                    children: cartItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: ProductCart(
                          category: item['category']!,
                          title: item['title']!,
                          price: item['price']!,
                          oldPrice: item['old-price']!,
                          image: item['image']!,
                          offer: item['offer']!,
                          returnday: item['returnday']!,
                          count: item['count']!,
                          reviews: item['reviews']!,
                        ),
                      );
                    }).toList(),
                  ),

                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                          child: Text('Price Details',style: Theme.of(context).textTheme.titleLarge),
                        ),
                        
                      ],
                    ),
                  )

                ]
              ),
            )
          )
        ],
      ),
    );
  }
}