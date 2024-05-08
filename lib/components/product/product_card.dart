import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {

  final String? category;
  final String title;
  final String image;
  final String price;
  final String oldPrice;
  final String offer;
  final dynamic addCartBtn;

  const ProductCard({super.key, 
    this.category,
    required this.title,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.offer,
    this.addCartBtn,
  });

  @override
  Widget build(BuildContext context){

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          right: BorderSide(width: 1,color: Theme.of(context).dividerColor),
          bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [  
              AspectRatio(
                aspectRatio: 1 / .9,
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.contain, // use this
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                  onPressed: () {}, 
                  iconSize: 20,
                  icon: SvgPicture.string(
                    IKSvg.heart,
                    width: 16,
                    height: 16,
                  ), 
                ),
              )
            ]
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if(category != null)
                  Text(category!, style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
                const SizedBox(height: 3),
                Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('\$$price',style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 6),
                    Text('\$$oldPrice',style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(decoration: TextDecoration.lineThrough))),
                    const SizedBox(width: 6),
                    Text(offer,style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: Color(0xFFEB5757)))),
                  ],
                ),
                if(addCartBtn != null)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(top: 8.0,bottom: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2,color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Text('Add To Cart',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary))),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}