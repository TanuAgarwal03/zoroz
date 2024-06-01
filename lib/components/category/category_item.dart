import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  final String title;
  final String image;

  const CategoryItem(this.title, this.image, {super.key});
  
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/products');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(60),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(image,height: 60,width: 60),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(title,style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(fontSize: 13,fontWeight: FontWeight.w400))),
          ],
        ),
      ),
    );
  }
}