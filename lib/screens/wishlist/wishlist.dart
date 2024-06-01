import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  
  Wishlist({ super.key });

  final List<Map<String, String>> wishlistItems = [
    {
      'title': 'Slim Leather Bifold Wallet in brown colour', 
      'image': IKImages.product16,
      'price' : '123',
      'old-price' : '150',
      'offer' : '15% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'Denim skinny fit jeans blue colour', 
      'image': IKImages.product13,
      'price' : '25',
      'old-price' : '35',
      'offer' : '25% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'Sony Bravia OLED TV', 
      'image': IKImages.product9,
      'price' : '25',
      'old-price' : '35',
      'offer' : '25% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'Polka dot wrap blouse silver', 
      'image': IKImages.product15,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'Pleated high-waisted red checked', 
      'image': IKImages.product14,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'LG TurboWash Washing machine', 
      'image': IKImages.product12,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'Ergonomic Office Chair', 
      'image': IKImages.product7,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product1,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'KitchenAid 9-Cup Food', 
      'image': IKImages.product11,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'Engraved Metal Money sofa 4', 
      'image': IKImages.product5,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'OnePlus Bullets EyeBuds', 
      'image': IKImages.product17,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
    },
    {
      'title': 'APPLE iPhone 14 (Blue ,256gb storage)', 
      'image': IKImages.product10,
      'price' : '105',
      'old-price' : '112',
      'offer' : '70% OFF',
      'in-wishlist' : '1',
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
              title: const Text('My Wishlist'),
              titleSpacing: 5,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('12 Items',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)),
                )
              ],
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: SingleChildScrollView(
            child: Wrap(
              children: wishlistItems.map((item) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width > IKSizes.container ? 
                      IKSizes.container / 3
                      : 
                      MediaQuery.of(context).size.width / 2
                  ,
                  child: ProductCard(
                    title: item['title']!,
                    image: item['image']!,
                    price: item['price']!,
                    oldPrice: item['old-price']!,
                    offer: item['offer']!,
                    addCartBtn : true,
                    inWishlist : item['in-wishlist']!,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}