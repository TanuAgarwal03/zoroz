import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCardList extends StatefulWidget {

  final String? category;
  final String title;
  final String price;
  final String oldPrice;
  final String image;
  final String returnday;
  final String count;
  final String offer;
  final String reviews;
  final bool? wishlistIcon;
  final String? productid;

  const ProductCardList({super.key, 
    this.category,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.returnday,
    required this.count,
    required this.offer,
    required this.reviews,
    this.wishlistIcon,
    this.productid,
  });

  @override
  State<ProductCardList> createState() => _ProductCardListState();
}

class _ProductCardListState extends State<ProductCardList> {
  
  dynamic _isWishlist = false;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product_detail', arguments: ScreenArguments(
            widget.title, 
            widget.image, 
            widget.price, 
            widget.oldPrice, 
            widget.offer
          )
        );
      },
      child: Container(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: 145,
                    height: 150,
                    child:  Image.asset(widget.image,width: double.infinity,height: double.infinity,),
                  ),
                ), 
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0,bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Apple',style:Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(widget.title,style:Theme.of(context).textTheme.titleMedium),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Text('\$${widget.price}',style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(width: 6),
                            Text('\$${widget.oldPrice}',style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(decoration: TextDecoration.lineThrough))),
                            const SizedBox(width: 6),
                            Text(widget.offer,style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: Color(0xFFEB5757)))),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
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
                            const SizedBox(width: 6),
                            Text('(${widget.reviews} Review)',style: Theme.of(context).textTheme.bodySmall)
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
                            Text('${widget.returnday} Days return available',style:Theme.of(context).textTheme.bodyMedium)
                          ]
                        )
                      ], 
                    ),
                  )
                ),
                const Spacer(flex: 1),
              ],
            ),
            if(widget.wishlistIcon != false)
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isWishlist = !_isWishlist;
                  });
                }, 
                iconSize: 20,
                icon: SvgPicture.string(
                  IKSvg.heart,
                  width: 16,
                  height: 16,
                  // ignore: deprecated_member_use
                  color: _isWishlist ? IKColors.danger : Theme.of(context).textTheme.bodyLarge?.color,
                ), 
              ),
            )
          ],
        ),
      ),
    );
  }
}