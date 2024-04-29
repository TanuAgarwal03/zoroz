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
    {'title': 'Electronics', 'image': IKImages.cat2},
    {'title': 'Camera', 'image': IKImages.cat3},
    {'title': 'Headphone', 'image': IKImages.cat4},
    {'title': 'TVs & LED', 'image': IKImages.cat5},
    {'title': 'Furniture', 'image': IKImages.cat6},
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
      'image': IKImages.product10,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'category' : 'Earbuds',
      'title': 'OnePlus Bullets EarBuds', 
      'image': IKImages.product17,
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
  ];

  final List<Map<String, String>> productItems3 = [
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
  ];

  final List<Map<String, String>> productItems2 = [
    {
      'title': 'Slim Leather Bifold Wallet in brown colour', 
      'image': IKImages.product16,
      'price' : '123',
      'old-price' : '150',
      'offer' : '15% OFF',
    },
    {
      'title': 'Denim skinny fit jeans blue colour', 
      'image': IKImages.product13,
      'price' : '25',
      'old-price' : '35',
      'offer' : '25% OFF',
    },
    {
      'title': 'Sony Bravia OLED TV', 
      'image': IKImages.product9,
      'price' : '25',
      'old-price' : '35',
      'offer' : '25% OFF',
    },
    {
      'title': 'Polka dot wrap blouse silver', 
      'image': IKImages.product15,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'Pleated high-waisted red checked', 
      'image': IKImages.product14,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'LG TurboWash Washing machine', 
      'image': IKImages.product12,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'Ergonomic Office Chair', 
      'image': IKImages.product7,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'KitchenAid 9-Cup Food', 
      'image': IKImages.product11,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'Engraved Metal Money sofa 4', 
      'image': IKImages.product5,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'OnePlus Bullets EyeBuds', 
      'image': IKImages.product17,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
    },
    {
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product10,
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
            TagSwiper(),
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
                  children: productItems3.map((item) {
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
            Wrap(
              children: productItems2.map((item) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width > 600 ? 
                      MediaQuery.of(context).size.width / 3
                      : 
                      MediaQuery.of(context).size.width / 2
                  ,
                  child: ProductCard(
                    category: 'null',
                    title: item['title']!,
                    image: item['image']!,
                    price: item['price']!,
                    oldPrice: item['old-price']!,
                    offer: item['offer']!,
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}