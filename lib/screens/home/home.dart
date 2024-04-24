import 'package:clickcart/components/category/category_item.dart';
import 'package:clickcart/components/home/category_list.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  Home({ super.key });

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
            const SizedBox(height: 10.0),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  // Expanded(),
                  SizedBox(width: 5),
                  // Expanded(),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Blockbuster deals',style: Theme.of(context).textTheme.headlineMedium)
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Offer Ends in',style: Theme.of(context).textTheme.bodySmall),
                            Text('09 : 32 : 45',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: IKColors.primary))),
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                          ),
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Headphone',style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
                              const SizedBox(height: 3),
                              Text('OnePlus Bullets Wireless Z2 Headphone',maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text('105',style: Theme.of(context).textTheme.headlineMedium),
                                  const SizedBox(width: 6),
                                  Text('112',style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(decoration: TextDecoration.lineThrough))),
                                ],
                              ),
                              AspectRatio(
                                aspectRatio: 1.5/1,
                                child:Image.asset(IKImages.productDetail1,fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Spacer(flex: 1),
                                  Expanded(
                                    child:Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Theme.of(context).dividerColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1/1,
                                        child: Image.asset(IKImages.productDetail1,fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child:Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Theme.of(context).dividerColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1/1,
                                        child: Image.asset(IKImages.productDetail2,fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child:Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Theme.of(context).dividerColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1/1,
                                        child: Image.asset(IKImages.productDetail3,fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child:Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Theme.of(context).dividerColor),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1/1,
                                        child: Image.asset(IKImages.productDetail4,fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: IKColors.primary,
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}