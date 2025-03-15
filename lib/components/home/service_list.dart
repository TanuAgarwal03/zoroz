import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clickcart/components/home/service_card.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  
  final bool? vertical;

  ServiceList({super.key, this.vertical});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  List<Map<String, String>> serviceList = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  Future<void> fetchServices() async {
  try {
    final url = Uri.parse('https://backend.vansedemo.xyz/api/setting/store/customization/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      // print('Decoded response: $decodedResponse');

      // If it's a list, use [0] to access the first item
      final Map<String, dynamic> data = decodedResponse is List
          ? decodedResponse[0]
          : decodedResponse;

      if (data.containsKey('footer')) {
        final footer = data['footer'];

        setState(() {
          serviceList = [
            {
              'icon': IKSvg.truck,
              'title': 'Free & Fast Shipping',
              'desc': footer['shipping_card']['en'] ,
            },
            {
              'icon': IKSvg.support,
              'title':  'Customer Support',
              'desc': footer['support_card']['en'],
            },
            {
              'icon': IKSvg.secure,
              'title':  'Secure Payment',
              'desc': footer['payment_card']['en'],
            },

          ];
        });
      } else {
        print('Footer data missing in response.');
      }
    } else {
      print('Failed to load services. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching services: $e');
  }
}


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
                width: widget.vertical == true  ? null : 250,
                child: ServiceCard(
                  icon: item['icon']!,
                  title: item['title']!,
                  desc: item['desc']!,
                  vertical : widget.vertical,
                ),
              );
          }).toList(),
        ),
      ),
    );
  }
}