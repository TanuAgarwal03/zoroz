import 'package:clickcart/components/product/product_card_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({ super.key });

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
              title: const Text('Track Order'),
              titleSpacing: 5,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                const ProductCardList(
                  title: 'APPLE iPhone 14 (Blue, 128 GB)', 
                  price: '\$105', 
                  oldPrice: '\$112', 
                  image: IKImages.product1, 
                  returnday: '14', 
                  count: "count", 
                  offer: '70% OFF', 
                  reviews: '132',
                  productid : '#22344862',
                  wishlistIcon : false,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                        ),
                        child: Text('Track Order',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      height: 20,
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: IKColors.primary,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.check,color: Colors.white,size: 16),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: IKColors.primary,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20,left: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  decoration: BoxDecoration(
                                    color: IKColors.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Order Placed',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: Colors.white))),
                                          const SizedBox(width: 10),
                                          Text('27 Dec 2023',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: Color.fromARGB(126, 255, 255, 255))))
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text('We have received your order',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: Colors.white)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      height: 20,
                                      color: IKColors.primary,
                                    ),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: IKColors.primary,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.check,color: Colors.white,size: 16),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: IKColors.primary,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20,left: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  decoration: BoxDecoration(
                                    color: IKColors.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Order Confirm',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: Colors.white))),
                                          const SizedBox(width: 10),
                                          Text('27 Dec 2023',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: Color.fromARGB(126, 255, 255, 255))))
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text('We has been confirmed',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: Colors.white)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      height: 20,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: Theme.of(context).cardColor),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20,left: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Order Processed',style: Theme.of(context).textTheme.titleLarge),
                                          const SizedBox(width: 10),
                                          Text('28 Dec 2023',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: IKColors.primary)))
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text('We are preparing your order',style: Theme.of(context).textTheme.bodyMedium)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      height: 20,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: Theme.of(context).cardColor),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20,left: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Ready To Ship',style: Theme.of(context).textTheme.titleLarge),
                                          const SizedBox(width: 10),
                                          Text('29 Dec 2023',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: IKColors.primary)))
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text('Your order is ready for shipping',style: Theme.of(context).textTheme.bodyMedium)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      height: 20,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: Theme.of(context).cardColor),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: Colors.transparent,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20,left: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Out For Delivery',style: Theme.of(context).textTheme.titleLarge),
                                          const SizedBox(width: 10),
                                          Text('30 Dec 2023',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: IKColors.primary)))
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text('Your order is out for delivery',style: Theme.of(context).textTheme.bodyMedium)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}