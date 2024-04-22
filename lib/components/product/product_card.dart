import 'package:clickcart/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final String category;
  final String title;
  final String image;
  final String price;
  final String oldPrice;
  final String offer;

  const ProductCard({super.key, 
    required this.category,
    required this.title,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.offer,
  });

  @override
  Widget build(BuildContext context){

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(right: BorderSide(width: 1,color: Theme.of(context).dividerColor))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / .9,
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.contain, // use this
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
                const SizedBox(height: 3),
                Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(price,style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 6),
                    Text(oldPrice,style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(decoration: TextDecoration.lineThrough))),
                    const SizedBox(width: 6),
                    Text(offer,style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: Color(0xFFEB5757)))),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}