import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {

  final String image;
  final String title;
  final String subtitle;
  final String offerTxt;
  final dynamic subtitleColor;
  final dynamic background;

  const OfferCard({super.key, 
    required this.image,
    required this.title,
    required this.offerTxt,
    required this.subtitle,
    required this.subtitleColor,
    required this.background,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 6,
          child: Container(
            height: 115,
            padding: const EdgeInsets.only(left: 12,top: 12,bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subtitle,style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: subtitleColor))),
                      const SizedBox(height: 3),
                      Text(title,maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium),
                      if(offerTxt != 'null')
                        Text(offerTxt,style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: Color(0xFFEB5757)))),
                    ],
                  )
                ), 
                
                TextButton(
                  onPressed: (){}, 
                  child: Text('Shop Now',style: Theme.of(context).textTheme.titleSmall)
                )
              ],
            ),
          )
        ),
        Expanded(
          flex: 4,
          child: Image.asset(image,height: 105,fit: BoxFit.contain),
        )
        
      ],
            ),
    );
  }
}