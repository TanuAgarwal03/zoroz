import 'package:flutter/material.dart';

class CategoryItem2 extends StatelessWidget {

  final String image;
  final String title;

  const CategoryItem2({super.key, 
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 8,right: 12),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1,color: Theme.of(context).dividerColor),
      ),
      child: Row(
        children: [
          Image.asset(image,height: 35,width: 42,fit: BoxFit.cover),
          const SizedBox(width: 4),
          Text(title,style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}