import 'package:clickcart/components/bottomsheet/filter_sheet.dart';
import 'package:clickcart/components/bottomsheet/short_by.dart';
import 'package:clickcart/components/home/category_list.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/components/product/product_card_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Products extends StatefulWidget {

  const Products({ super.key });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  String _productView = "grid";

  final List<Map<String, String>> wishlistItems = [
    {
      'title': 'Slim Leather Bifold Wallet in brown colour', 
      'image': IKImages.product16,
      'price' : '123',
      'old-price' : '150',
      'offer' : '15% OFF',
      'reviews' : '150',
      'returnday' : '12',
    },
    {
      'title': 'Denim skinny fit jeans blue colour', 
      'image': IKImages.product13,
      'price' : '25',
      'old-price' : '35',
      'offer' : '25% OFF',
      'reviews' : '84',
      'returnday' : '24',
    },
    {
      'title': 'Sony Bravia OLED TV', 
      'image': IKImages.product9,
      'price' : '25',
      'old-price' : '35',
      'offer' : '25% OFF',
      'reviews' : '25',
      'returnday' : '10',
    },
    {
      'title': 'Polka dot wrap blouse silver', 
      'image': IKImages.product15,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '143',
      'returnday' : '8',
    },
    {
      'title': 'Pleated high-waisted red checked', 
      'image': IKImages.product14,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '76',
      'returnday' : '11',
    },
    {
      'title': 'LG TurboWash Washing machine', 
      'image': IKImages.product12,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '123',
      'returnday' : '12',
    },
    {
      'title': 'Ergonomic Office Chair', 
      'image': IKImages.product7,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '89',
      'returnday' : '16',
    },
    {
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '62',
      'returnday' : '2',
    },
    {
      'title': 'KitchenAid 9-Cup Food', 
      'image': IKImages.product11,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '85',
      'returnday' : '10',
    },
    {
      'title': 'Engraved Metal Money sofa 4', 
      'image': IKImages.product5,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '64',
      'returnday' : '14',
    },
    {
      'title': 'OnePlus Bullets EyeBuds', 
      'image': IKImages.product17,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '55',
      'returnday' : '15',
    },
    {
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product10,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'reviews' : '12',
      'returnday' : '2',
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
              title: const Text('Product Grid'),
              titleSpacing: 5,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search_screen');
                  }, 
                  iconSize: 28,
                  icon: SvgPicture.string(IKSvg.search),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      }, 
                      iconSize: 28,
                      // ignore: deprecated_member_use
                      icon: SvgPicture.string(IKSvg.cart,height: 20,width: 20, color: Colors.white),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: IKColors.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text('14',style: TextStyle(color: Colors.black,fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: Column(
            children: [
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
                      child: GestureDetector(
                        onTap: (){ 
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const ShortBy();
                            },
                          );
                        },
                        child : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1,color: Theme.of(context).dividerColor)) 
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.string(
                                IKSvg.sort,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('SORT',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w400)))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){ 
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const FilterSheet();
                            },
                          );
                        },
                        child : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1,color: Theme.of(context).dividerColor)) 
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.string(
                                IKSvg.filter,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('FILTER',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w400)))
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){ 
                        setState(() {
                          _productView = 'list';
                        });
                      },
                      child : Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: 1,color: Theme.of(context).dividerColor)) 
                        ),
                        child: SvgPicture.string(
                          IKSvg.list,
                          width: 20,
                          height: 20,
                          // ignore: deprecated_member_use
                          color: _productView == "list" ? IKColors.primary : Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){ 
                        setState(() {
                          _productView = 'grid';
                        });
                      },
                      child : Container(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.string(
                          IKSvg.grid,
                          width: 20,
                          height: 20,
                          // ignore: deprecated_member_use
                          color: _productView == "grid" ? IKColors.primary : Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryList(),
                      Wrap(
                        children: wishlistItems.map((item) {
                          return SizedBox(
                            width: _productView == "list" ? null : MediaQuery.of(context).size.width > IKSizes.container ? 
                                IKSizes.container / 3
                                : 
                                MediaQuery.of(context).size.width / 2
                            ,
                            child:
                            _productView == "list" ?
                            Padding(
                              padding: const EdgeInsets.only(bottom:10.0),
                              child: ProductCardList(
                                title: item['title']!, 
                                price: item['price']!, 
                                oldPrice: item['old-price']!, 
                                image: item['image']!, 
                                returnday: item['returnday']!, 
                                count: "count", 
                                offer: item['offer']!, 
                                reviews: item['reviews']!
                              ),
                            )
                            :
                            ProductCard(
                              title: item['title']!,
                              image: item['image']!,
                              price: item['price']!,
                              oldPrice: item['old-price']!,
                              offer: item['offer']!,
                            ),
                          );
                        }).toList(),
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