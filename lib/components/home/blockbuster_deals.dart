import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class BlockbusterDeals extends StatefulWidget {

  const BlockbusterDeals({ super.key });

  @override
  State<BlockbusterDeals> createState() => _BlockbusterDealsState();
}

class _BlockbusterDealsState extends State<BlockbusterDeals> {

  String imagePath = IKImages.productDetail1;

  void changeImage(val) {
    setState(() {
      imagePath = val;
    });
  }

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
                    const OfferCountdown(),
                    // Text('09 : 32 : 45',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: IKColors.primary))),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/product_detail', arguments: ScreenArguments(
                        'OnePlus Bullets Wireless Z2 Headphone', 
                        imagePath, 
                        '\$105', 
                        '\$112', 
                        '70% off'
                      )
                    );
                  },
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
                            Text('\$105',style: Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(width: 6),
                            Text('\$112',style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(decoration: TextDecoration.lineThrough))),
                          ],
                        ),
                        AspectRatio(
                          aspectRatio: 1.5/1,
                          child:Image.asset(imagePath,fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Spacer(flex: 1),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(IKImages.productDetail1);
                                },
                                child:  Container(
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
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(IKImages.productDetail2);
                                },
                                child: Container(
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
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(IKImages.productDetail3);
                                },
                                child: Container(
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
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  changeImage(IKImages.productDetail4);
                                },
                                child: Container(
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
                            ),
                            const Spacer(flex: 1),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/product_detail', arguments: ScreenArguments(
                          'Braun Series 9 Electric Shaver', 
                          IKImages.product2, 
                          '\$105', 
                          '\$112', 
                          '70% off'
                          )
                        );
                      },
                      child: Container(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/product_detail', arguments: ScreenArguments(
                          'Hooded zip-up hoodie', 
                          IKImages.product3, 
                          '\$105', 
                          '\$112', 
                          '70% off'
                          )
                        );
                      },
                      child: Container(
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



class OfferCountdown extends StatefulWidget {
  const OfferCountdown({super.key});

  @override
  State<OfferCountdown> createState() => _OfferCountdownState();
}

class _OfferCountdownState extends State<OfferCountdown> {
  late final StreamDuration _streamDuration;

  @override
  void initState() {
    super.initState();
    _streamDuration = StreamDuration(
      config: const StreamDurationConfig(
        countDownConfig: CountDownConfig(
          duration: Duration(days: 2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamDuration.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideCountdown(
          // This duration no effect if you customize stream duration
          streamDuration: _streamDuration,
          style: const TextStyle(
            color: IKColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
          separatorStyle: const TextStyle(color: IKColors.primary,fontWeight: FontWeight.w500),
          padding: const EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 3),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
      ],
    );
  }
}