import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  final String title;
  final dynamic icon;

  const ListItem({ super.key, required this.title, this.icon });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,style:Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontWeight: FontWeight.w400)))
          ),
          Icon(Icons.chevron_right,color: Theme.of(context).textTheme.titleMedium?.color)
        ],
      ),
    );
  }
}