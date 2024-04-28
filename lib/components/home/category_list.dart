import 'package:clickcart/components/category/category_item2.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  
  CategoryList({super.key});

  final List<Map<String, String>> categoryList = [
    {
      'image' : IKImages.cat01,
      'title' : 'Fashion',
    },
    {
      'image' : IKImages.cat02,
      'title' : 'Beauty',
    },
    {
      'image' : IKImages.cat03,
      'title' : 'Home',
    },
    {
      'image' : IKImages.cat04,
      'title' : 'Mobile',
    },
    {
      'image' : IKImages.cat01,
      'title' : 'Fashion',
    },
  ];

  @override
  Widget build(BuildContext context){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: categoryList.map((item) {
            return 
              CategoryItem2(
                image: item['image']!,
                title: item['title']!,
              );
          }).toList(),
        ),
      ),
    );
  }
}