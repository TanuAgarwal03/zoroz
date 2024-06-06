import 'package:clickcart/components/product/product_cart.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrders extends StatefulWidget {

  const MyOrders({ super.key });

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

final List<Map<String, String>> orderItems = [
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
    'order-status' : 'ongoing',
    'order-rated' : 'no',
  },
  {
    'id' : "2",
    'category' : 'Apple',
    'title': 'Polka dot wrap blouse', 
    'image': IKImages.product15,
    'price' : '135',
    'old-price' : '152',
    'offer' : '30% OFF',
    'returnday' : '14',
    'count' : '10',
    'reviews' : '240',
    'order-rated' : 'yes',
    'order-status' : 'completed',
  },
  {
    'id' : "3",
    'category' : 'Apple',
    'title': 'Cuisinart Compact 2-Slice', 
    'image': IKImages.product9,
    'price' : '125',
    'old-price' : '164',
    'offer' : '45% OFF',
    'returnday' : '14',
    'count' : '8',
    'reviews' : '180',
    'order-status' : 'completed',
    'order-rated' : 'no',
  },
  {
    'id' : "4",
    'category' : 'Apple',
    'title': 'LG TurboWash Washing', 
    'image': IKImages.product12,
    'price' : '100',
    'old-price' : '112',
    'offer' : '15% OFF',
    'returnday' : '14',
    'count' : '7',
    'reviews' : '150',
    'order-status' : 'ongoing',
    'order-rated' : 'no',
  },
  {
    'id' : "5",
    'category' : 'Apple',
    'title': 'KitchenAid 9-Cup Food', 
    'image': IKImages.product11,
    'price' : '15',
    'old-price' : '20',
    'offer' : '25% OFF',
    'returnday' : '14',
    'count' : '4',
    'reviews' : '180',
    'order-status' : 'completed',
    'order-rated' : 'no',
  },
];

class _MyOrdersState extends State<MyOrders> {

  List _orderData = orderItems;
  String _activeFilter = 'all';

  void removeItem(id){
    setState(() {
      _orderData.removeWhere((item) => item['id'] == id);
    });
  }

  void _orderFilter(val) {
    setState(() {
      _activeFilter = val;
      if(val == 'all'){
        _orderData = orderItems;
      }else{
        _orderData = orderItems.where((i) => i['order-status'] == val).toList();
      }
    });
  }

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
              title: const Text('My Order'),
              titleSpacing: 5,
              centerTitle: true,
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 52),
                child: Column(
                  children: _orderData.map((item) {
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
                        orderStatus : item['order-status']!,
                        orderRated : item['order-rated']!,
                        bottomOption : 'order',
                        removePress :(){ 
                          removeItem(item['id']);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _orderFilter('all');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            child: Text('All',style: Theme.of(context).textTheme.titleLarge?.merge(TextStyle(fontSize: 15,color: _activeFilter == 'all' ? IKColors.primary : Theme.of(context).textTheme.titleMedium?.color))),
                          ),
                        )
                      ),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            _orderFilter('ongoing');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.string(
                                  IKSvg.truck3,
                                  width: 14,
                                  height: 14,
                                ),
                                const SizedBox(width: 4),
                                Text('Ongoing',style: Theme.of(context).textTheme.titleLarge?.merge(TextStyle(fontSize: 15,color: _activeFilter == 'ongoing' ? IKColors.primary : Theme.of(context).textTheme.titleMedium?.color))),
                              ],
                            ),
                          ),
                        )
                      ),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            _orderFilter('completed');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.string(
                                  IKSvg.checkbox,
                                  width: 14,
                                  height: 14,
                                ),
                                const SizedBox(width: 4),
                                Text('Completed',style: Theme.of(context).textTheme.titleLarge?.merge(TextStyle(fontSize: 15,color: _activeFilter == 'completed' ? IKColors.primary : Theme.of(context).textTheme.titleMedium?.color))),
                              ],
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}