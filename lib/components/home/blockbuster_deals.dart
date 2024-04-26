import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class BlockbusterDeals extends StatelessWidget {

  const BlockbusterDeals({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                      ),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1/.8,
                            child: Image.asset(IKImages.product2,fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 5),
                          Text('Braun Series 9 Electric Shaver',textAlign:TextAlign.center,style: Theme.of(context).textTheme.titleSmall)
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1/.8,
                            child: Image.asset(IKImages.product3,fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 5),
                          Text('Hooded zip-up hoodie',textAlign:TextAlign.center,style: Theme.of(context).textTheme.titleSmall)
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}