import 'package:card_swiper/card_swiper.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({ super.key });

  final List<Map<String, String>> productVariants = [
    {
      'title' : 'Color',
      'value' : 'Blue',
    },
    {
      'title' : 'Storage',
      'value' : '128GB Storage',
    },
    {
      'title' : 'RAM',
      'value' : '6GB RAM',
    },
    {
      'title' : 'Size',
      'value' : 'Medium',
    },
  ];

  final List<Map<String, dynamic>> productSpecs = [
    {
      'title' : 'GENERAL',
      'data' : <Map<String, String>> [
        {
          'label' : 'Country of Origin',
          'value' : 'China',
        },
        {
          'label' : 'Sim Type',
          'value' : 'Dual Sim, GSM+GSM',
        },
        {
          'label' : 'Dual Sim',
          'value' : 'Yes',
        },
        {
          'label' : 'Sim Size',
          'value' : 'Nano + eSIM',
        },
        {
          'label' : 'Device Type',
          'value' : 'Smartphone',
        },
        {
          'label' : 'Release Date',
          'value' : 'September 07, 2022',
        },
      ],
    },
    {
      'title' : 'DESIGN',
      'data' : <Map<String, String>> [
        {
          'label' : 'Dimensions',
          'value' : '71.5 x 146.7 x 7.8 mm',
        },
        {
          'label' : 'Weight',
          'value' : '172 g',
        },
        {
          'label' : 'Colors',
          'value' : 'Blue, Purple, Yellow, Midnight',
        },
      ],
    },
    {
      'title' : 'DISPLAY',
      'data' : <Map<String, String>> [
        {
          'label' : 'Type',
          'value' : 'Color OLED Screen (16M Colors)',
        },
        {
          'label' : 'Touch',
          'value' : 'Yes',
        },
        {
          'label' : 'Size',
          'value' : '6.1inches, 1170x2532pixels',
        },
        {
          'label' : 'Aspect Ratio',
          'value' : '19.5:9',
        },
        {
          'label' : 'PPI',
          'value' : '~ 460PPI',
        },
        {
          'label' : 'Glass Type',
          'value' : 'Ceramic Shield Front, Glass Back',
        },
        {
          'label' : 'Features',
          'value' : 'HDR Display',
        },
        {
          'label' : 'Notch',
          'value' : 'Yes, Small Notch',
        },
      ],
    },
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

  final List<Map<String, dynamic>> productImages = [
    {'image': IKImages.product1},
    {'image': IKImages.product2},
    {'image': IKImages.product3},
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        titleSpacing: 5,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    constraints: const BoxConstraints(
                      minHeight: 174,
                      maxHeight: 350,
                    ),
                    height: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Swiper(
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(30),
                              child : Image.asset(productImages[index]['image'],fit: BoxFit.contain)
                            );
                          },
                          // indicatorLayout: PageIndicatorLayout.COLOR,
                          autoplay: true,
                          itemCount: productImages.length,
                          pagination: const SwiperPagination(
                            builder:DotSwiperPaginationBuilder(
                              size: 8,
                              activeSize: 8,
                              color: Color.fromARGB(36, 40, 117, 240),
                              activeColor: IKColors.primary,
                              space: 4,
                            )
                          )
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 1),
                            color: IKColors.success,
                            child: const Text('70% OFF',style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600)),
                          )
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: IconButton(
                            onPressed: () {}, 
                            iconSize: 20,
                            icon: SvgPicture.string(
                              IKSvg.heart,
                              width: 20,
                              height: 20,
                            ), 
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 50,
                          child: IconButton(
                            onPressed: () {}, 
                            iconSize: 20,
                            icon: SvgPicture.string(
                              IKSvg.share,
                              width: 20,
                              height: 20,
                            ), 
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xFFC5F4FF),
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Image.asset(IKImages.giftBox,height: 45)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('APPLE iPhone 14 (Blue, 128 GB)',style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFFFA048),
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFFFA048),
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFFFA048),
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFFFA048),
                            ),
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Color(0xFFFFA048),
                            ),
                            const SizedBox(width: 8),
                            Text('(270 Review)',style: Theme.of(context).textTheme.bodyMedium)
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Text('\$6,499',style: Theme.of(context).textTheme.headlineLarge?.merge(const TextStyle(fontWeight: FontWeight.w600,color: IKColors.success))),
                            const SizedBox(width: 6),
                            Text('\$7,000',style: Theme.of(context).textTheme.headlineLarge?.merge(TextStyle(decoration: TextDecoration.lineThrough,color: Theme.of(context).textTheme.bodyMedium?.color))),
                            const SizedBox(width: 10),
                            Text('70% OFF',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.danger))),
                            const SizedBox(width: 10),
                            Text('In Stock',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.success,fontSize: 15))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: IKColors.primary,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              margin: const EdgeInsets.only(right: 4),
                              height: 14,
                              width: 14,
                              child: const Icon(Icons.reply,size: 12,color: Colors.white)
                            ),
                            Text('14 Days return available',style:Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(width: 10),
                            Text('Free delivery',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.success,fontSize: 15))),
                          ]
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                          child: Text('Select Variant',style: Theme.of(context).textTheme.titleLarge),
                        ),
                        Column(
                          children: productVariants.map((item){
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15))),
                                  ),
                                  Text(item['value']!,style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15))),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.chevron_right,color: IKColors.primary),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  ServiceList(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Description:',style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 6),
                        Text('Apple iPhone 14 price in India starts from ₹54,994. It is available at lowest price on Croma in India as on Feb 22, 2024. Take a look at Apple iPhone 14 detailed specifications and features.',style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child:Text('Apple iPhone 14 Full Specs',style:Theme.of(context).textTheme.titleLarge),
                        ),
                        Column(
                          children: productSpecs.map((item){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  color: Theme.of(context).dividerColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                                  child: Text(item['title'],style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400,fontSize: 13))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Column(
                                    children: (item['data'] as List<Map<String, String>>).map((data) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(data['label']!,style:Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontWeight: FontWeight.w500))),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(data['value']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)))
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                          ),
                          child: Text('Similar Products',style: Theme.of(context).textTheme.headlineMedium),
                        ),
                        SingleChildScrollView(
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
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
          Container(
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
                  child: ElevatedButton(
                    onPressed: (){}, 
                    child: Text('Add To Cart',style: TextStyle(color: IKColors.primary,fontSize: 16,fontWeight: FontWeight.w400)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                    ),
                  )
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){}, 
                    child: Text('Buy Now',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      backgroundColor: IKColors.secondary,
                      side: const BorderSide(color: IKColors.secondary),
                    ),
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}