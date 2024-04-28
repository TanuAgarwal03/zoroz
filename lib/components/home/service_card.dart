import 'package:clickcart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceCard extends StatelessWidget {

  final String icon;
  final String title;
  final String desc;

  const ServiceCard({super.key, 
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context){
    return Container( 
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).cardTheme.color,
      ),
      child: Row(
        children: [
          SvgPicture.string(
            icon,
            width: 45,
            height: 45,
            color: IKColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(desc, style: Theme.of(context).textTheme.bodySmall),
              ],
            )
          )
        ],
      ),
    );
  }
}