import 'package:clickcart/components/home/service_card.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatelessWidget {
  
  ServiceList({super.key});

  final List<Map<String, String>> serviceList = [
    {
      'icon' : IKSvg.truck,
      'title' : 'Free Shipping & Returns',
      'desc' : 'For all orders over 99',
    },
    {
      'icon' : IKSvg.truck,
      'title' : 'Free Shipping & Returns',
      'desc' : 'For all orders over 99',
    },
    {
      'icon' : IKSvg.truck,
      'title' : 'Free Shipping & Returns',
      'desc' : 'For all orders over 99',
    },
  ];

  @override
  Widget build(BuildContext context){

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: serviceList.map((item) {
            return 
              SizedBox(
                width: 250,
                child: ServiceCard(
                  icon: item['icon']!,
                  title: item['title']!,
                  desc: item['desc']!,
                ),
              );
          }).toList(),
        ),
      ),
    );
  }
}