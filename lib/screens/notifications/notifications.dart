import 'package:clickcart/components/home/tag_swiper.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notifications extends StatelessWidget {

  Notifications({ super.key });

  final List<Map<String, dynamic>> notificationData = [
    {
      'image' : IKImages.chatUser1,
      'title' : 'New Arrivals Alert!',
      'date' : '15 July 2023',
    },
    {
      'image' : IKImages.chatUser2,
      'title' : 'Flash Sale Announcement',
      'date' : '15 July 2023',
    },
    {
      'title' : 'Crazy Deals',
      'data' : <Map<String, String>> [
        {
          'category' : 'Electronics',
          'title': 'LG TurboWash Washing machine automatic', 
          'image': IKImages.product12,
          'price' : '105',
          'old-price' : '112',
          'offer' : '70% OFF',
        },
        {
          'category' : 'Electronics',
          'title': 'KitchenAid 9-Cup Food', 
          'image': IKImages.product11,
          'price' : '105',
          'old-price' : '112',
          'offer' : '70% OFF',
        },
        {
          'category' : 'Furniture',
          'title': 'Wooden chair for kitchen', 
          'image': IKImages.product7,
          'price' : '105',
          'old-price' : '112',
          'offer' : '70% OFF',
        },
        {
          'category' : 'Electronics',
          'title': 'LG TurboWash Washing machine', 
          'image': IKImages.product12,
          'price' : '105',
          'old-price' : '112',
          'offer' : '70% OFF',
        }, 
      ]
    },
    {
      'image' : IKImages.brand4,
      'title' : 'Exclusive Discounts Inside',
      'date' : '15 July 2023',
    },
    {
      'image' : IKImages.chatUser3,
      'title' : 'Limited Stock - Act Fast!',
      'date' : '15 July 2023',
    },
    {
      'title' : 'offer-banner-2',
      'data' : <Map<String, String>> [
        {
          'image': IKImages.banner6,
        },
        {
          'image': IKImages.banner5,
        },
      ]
    },
    {
      'image' : IKImages.chatUser4,
      'title' : 'Get Ready to Shop',
      'date' : '15 July 2023',
    },
    {
      'image' : IKImages.brand9,
      'title' : "Don't Miss Out on Savings",
      'date' : '15 July 2023',
    },
    {
      'image' : IKImages.chatUser5,
      'title' : "Special Offer Just for You",
      'date' : '15 July 2023',
    },
    {
      'title' : 'offer-banner-1',
      'image' : IKImages.banner1
     },
    {
      'image' : IKImages.chatUser6,
      'title' : "Don't Miss Out on Savings",
      'date' : '15 July 2023',
    },
    {
      'image' : IKImages.brand1,
      'title' : "Get Ready to Shop",
      'date' : '15 July 2023',
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
              title: const Text('Notifications (12)'),
              titleSpacing: 5,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search_screen');
                  }, 
                  iconSize: 28,
                  icon: SvgPicture.string(IKSvg.search),
                ),
              ],
            ),
          ),
        )
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: notificationData.map((item){
                    if(item['title'] == 'Crazy Deals'){
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                              child: Text(item['title']!,style: Theme.of(context).textTheme.titleLarge),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: (item['data'] as List<Map<String, String>>).map((item) {
                                  return 
                                    SizedBox(
                                      width: 162,
                                      child : ProductCard(
                                          category: item['category']!,
                                          title: item['title']!,
                                          image: item['image']!,
                                          price: item['price']!,
                                          oldPrice: item['old-price']!,
                                          offer: item['offer']!,
                                        )
                                    );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      );
                    }else if(item['title'] == 'offer-banner-2'){
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: (item['data'] as List<Map<String, String>>).map((item) {
                              return 
                                SizedBox(
                                  width: MediaQuery.of(context).size.width > IKSizes.container ?
                                    (IKSizes.container - 5) / 2
                                    :
                                    (MediaQuery.of(context).size.width - 5) / 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/products');
                                    },
                                    child: Image.asset(item['image']!)
                                  ),
                                );
                            }).toList(),
                          ),
                        );
                    }else if(item['title'] == 'offer-banner-1'){
                      return Container(
                        color: Theme.of(context).cardColor,
                        child: Image.asset(item['image'],width: double.infinity),
                      );
                    } else{
                      return  Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(item['image']!,height: 45,width: 45),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(item['title']!,style: Theme.of(context).textTheme.titleLarge),
                                  const SizedBox(height: 6),
                                  Text(item['date']!,style: Theme.of(context).textTheme.bodySmall),
                                ],
                              )
                            )
                          ],
                        ),
                      ); 
                    }
                  }).toList(),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
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
                  child: TagSwiper(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}