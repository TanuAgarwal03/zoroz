import 'package:clickcart/components/category/category_item.dart';
import 'package:clickcart/components/home/banner_swiper.dart';
import 'package:clickcart/components/home/blockbuster_deals.dart';
import 'package:clickcart/components/home/category_list.dart';
import 'package:clickcart/components/home/home_decor.dart';
import 'package:clickcart/components/home/sponserd_list.dart';
import 'package:clickcart/components/home/tag_swiper.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  Home({ super.key });

final List<String> items = List.generate(20, (index) => 'Item $index');

  final List<Map<String, String>> categoryItems = [
    {'title': 'Mobiles', 'image': IKImages.cat1},
    {'title': 'Electronics', 'image': IKImages.cat1},
    {'title': 'Camera', 'image': IKImages.cat1},
    {'title': 'Headphone', 'image': IKImages.cat1},
    {'title': 'TVs & LED', 'image': IKImages.cat1},
    {'title': 'Furniture', 'image': IKImages.cat1},
  ];

  final List<Map<String, String>> productItems = [
    {
      'category' : 'Mobile',
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'category' : 'Mobile',
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'category' : 'Mobile',
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'category' : 'Mobile',
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
  ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(IKImages.logo,height: 24,),
        titleSpacing: 5,
        leading: IconButton(
          onPressed: () {},
          iconSize: 28,
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            iconSize: 28,
            icon: const Icon(Icons.search)
          ),
          IconButton(
            onPressed: () {}, 
            iconSize: 28,
            icon: const Icon(Icons.notifications_none)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TagSwiper(),
            BannerSwiper(),
            const SizedBox(height: 10.0),
            Container(
              color: Theme.of(context).cardColor,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                  children: categoryItems.map((item) {
                    return CategoryItem(item['title']!, item['image']!);
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(IKImages.banner5),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Image.asset(IKImages.banner6),
                  ),
                  // Expanded(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              color: Theme.of(context).cardColor,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Top Deals Of The Day',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text('Offer Ends in',
                              style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: Color(0xFFBF0A30))),
                            ),
                            const SizedBox(width: 10,)
                          ],
                        )
                      ],
                    )
                  ),
                  Image.asset(IKImages.dailyOffer,height: 65,) 
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productItems.map((item) {
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
              ),
            ),
            ServiceList(),
            Image.asset(IKImages.banner1,width: double.infinity),
            CategoryList(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: Theme.of(context).cardColor,
              child: Row(
                children: [
                  Expanded(
                    child: Text('Home & Kitchen Essentials',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Image.asset(IKImages.ktEssential,height: 60) 
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productItems.map((item) {
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(IKImages.banner4),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Image.asset(IKImages.banner3),
                  ),
                  // Expanded(),
                ],
              ),
            ),
            const BlockbusterDeals(),
            const SizedBox(height: 12),
            Image.asset(IKImages.banner2,width: double.infinity),
            const HomeDecor(),
            SponserdList(),
            CategoryList(),
            // SliverGrid(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //   delegate: SliverChildListDelegate(
            //     [
            //       Image.network('https://picsum.photos/250?image=1'),
            //       Image.network('https://picsum.photos/250?image=1'),
            //       Image.network('https://picsum.photos/250?image=1'),
            //       Image.network('https://picsum.photos/250?image=1'),
            //       Image.network('https://picsum.photos/250?image=1'),
            //     ],
            //   ),
            // ),
            // GridView.count(
            //   crossAxisCount: 2,
            //   children: <Widget>[
            //     Image.network('https://picsum.photos/250?image=1'),
            //     Image.network('https://picsum.photos/250?image=1'),
            //     Image.network('https://picsum.photos/250?image=1'),
            //     Image.network('https://picsum.photos/250?image=1'),
            //     Image.network('https://picsum.photos/250?image=1'),
            //   ],
            // )
            // GridView(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //   ),
            //   children: [
            //     Image.network('https://picsum.photos/250?image=1'),
            //     Image.network('https://picsum.photos/250?image=2'),
            //     Image.network('https://picsum.photos/250?image=3'),
            //     Image.network('https://picsum.photos/250?image=4'),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}