import 'package:clickcart/utils/constants/colors.dart';
// import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ScreenArguments {
  final String title;
  final String image;
  final String price;
  final String oldPrice;
  final String offer;
  final String itemNo;
  final String slug;

  ScreenArguments(this.title, this.image, this.price, this.oldPrice, this.offer,
      this.itemNo, this.slug);
}

class ProductCard extends StatefulWidget {
  final String? category;
  final String title;
  final String image;
  final String price;
  final String oldPrice;
  final String offer;
  final dynamic addCartBtn;
  final String? inWishlist;
  final String itemNo;
  final String slug;

  const ProductCard({
    super.key,
    this.category,
    required this.title,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.offer,
    this.addCartBtn,
    this.inWishlist,
    required this.itemNo,
    required this.slug,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // late dynamic _isWishlist;

  @override
  void initState() {
    super.initState();
    // _isWishlist = widget.inWishlist == '1' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product_detail',
            arguments: ScreenArguments(widget.title, widget.image, widget.price,
                widget.oldPrice, widget.offer, widget.itemNo, widget.slug));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
                right:
                    BorderSide(width: 1, color: Theme.of(context).dividerColor),
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).dividerColor))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(children: [
              AspectRatio(
                  aspectRatio: 1 / .9,
                  child: Image.network(widget.image, fit: BoxFit.contain)),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.category != null)
                    Text(widget.category!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.merge(const TextStyle(color: IKColors.primary))),
                  const SizedBox(height: 3),
                  // Text(widget.title,maxLines: 2, overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(
                    height:
                        38, // Approx height for 2 lines, adjust as per your textTheme fontSize
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),

                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('\₹${widget.price}',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 6),
                      (widget.offer == '0')
                          ? const Text('')
                          : Text('₹${widget.oldPrice}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.merge(const TextStyle(
                                      decoration: TextDecoration.lineThrough))),
                      const SizedBox(width: 6),
                      (widget.offer == '0')
                          ? const Text('')
                          : Text(widget.offer,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.merge(const TextStyle(
                                      color: Color(0xFFEB5757)))),
                    ],
                  ),
                  if (widget.addCartBtn != null)
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('Add To Cart',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.merge(
                                    const TextStyle(color: IKColors.primary))),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
