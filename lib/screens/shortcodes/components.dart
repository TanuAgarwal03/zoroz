import 'package:clickcart/screens/shortcodes/subcategories.dart';
// import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/components/list/list_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loading_indicator/loading_indicator.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://backend.vansedemo.xyz/api/category/show');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      setState(() {
        categories = extractVisibleChildren(data);
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  List extractVisibleChildren(List data) {
    for (var item in data) {
      if (item['name']['en'] == "Home" && item['status'] == 'show') {
        return item['children']
            .where((child) => child['status'] == 'show')
            .toList();
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: categories.isEmpty
          ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 25,child: LoadingIndicator(indicatorType: Indicator.lineScalePulseOut)),
              ],
            ),
          )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                var category = categories[index];
                return CategoryItem(category: category);
              },
            ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Map category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    String title = category['name']['en'];
    String iconUrl = category['icon'] ?? "";

    return Column(
      children: [
        ListItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubCategoriesScreen(category: category),
              ),
            );
          },
          icon: iconUrl.isNotEmpty
              ? Image.network(
                  category['icon'],
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 25),
                )
              : const Icon(Icons.image_not_supported, size: 25),
          title: title,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

