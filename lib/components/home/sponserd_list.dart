import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class SponserdList extends StatelessWidget {

  SponserdList({ super.key });

  final List<Map<String, String>> sponsoredItems = [
    {'image': IKImages.sponsored1},
    {'image': IKImages.sponsored2},
    {'image': IKImages.sponsored3},
    {'image': IKImages.sponsored4},
  ];

  @override
  Widget build(BuildContext context){
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Text('Sponsored',style: Theme.of(context).textTheme.headlineMedium),
                ),
                Text('Min. 30% Off',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: Color(0xFF219653)))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15,right: 5),
              child: Row(
                children: sponsoredItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.asset(item['image']!,width: 170)
                    ),
                  );
                }).toList()
              ),
            ),
          ),
        ],
      ),
    );
  }
}