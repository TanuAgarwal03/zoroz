import 'package:clickcart/screens/shortcodes/subcategories.dart';
// import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/components/list/list_item.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loading_indicator/loading_indicator.dart';

// class Components extends StatefulWidget {
//   const Components({super.key});

//   @override
//   State<Components> createState() => _ComponentsState();
// }

// class _ComponentsState extends State<Components> {
//   List categories = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     final url = Uri.parse('https://backend.vansedemo.xyz/api/category/show');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       setState(() {
//         categories = extractVisibleChildren(data);
//       });
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }

//   List extractVisibleChildren(List data) {
//     for (var item in data) {
//       if (item['name']['en'] == "Home" && item['status'] == 'show') {
//         return item['children']
//             .where((child) => child['status'] == 'show')
//             .toList();
//       }
//     }
//     return [];
//   }

//   String generateSlug(String title) {
//     return title.toLowerCase().replaceAll("&", "").replaceAll(" ", "-");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
//           child: Container(
//             alignment: Alignment.center,
//             child: Container(
//               constraints: const BoxConstraints(maxWidth: IKSizes.container),
//               child: AppBar(
//                 title: const Text('Categories'),
//                 titleSpacing: 5,
//               ),
//             ),
//           )),

// body: Container(
//   alignment: Alignment.topCenter,
//   child: Container(
//     constraints: const BoxConstraints(
//       maxWidth: IKSizes.container,
//     ),
//     child: SingleChildScrollView(
//       padding: const EdgeInsets.all(15),
//       child:
//       Column(children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height*0.9,
//           child:
//           ListView.builder(
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               var category = categories[index];
//                String slug = generateSlug(category['name']['en']);
//                 String id = category['_id'];
//               String title = category['name']['en'];
//               String imageUrl =
//                   category['icon'] ?? ""; // Use icon if available

//               // Fallback image if 'icon' is empty
//               if (imageUrl.isEmpty) {
//                 imageUrl =
//                     "https://img.myipadbox.com/upload/store/product_l/${category['itemNo']}.jpg";
//               }

//               return Column(
//                 children: [
//                   ListItem(
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/products',
//                         arguments: {'slug': slug, 'id': id},
//                       );
//                     },
//                     icon: imageUrl.isNotEmpty
//                         ? Image.network(
//                             category['icon'],
//                             width: 20, // Adjust size as needed
//                             height: 20,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 const Icon(Icons.image_not_supported,
//                                     size: 25),
//                           )
//                         : const Icon(Icons.image_not_supported, size: 50),
//                     title: title,
//                   ),
//                   const SizedBox(height: 5),
//                 ],
//               );
//             },
//           ),
//         ),
//       ]),
//     ),
//   ),
// ),
//     );
//   }
// }

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

  // Extract children where parent is 'Home' and status is 'show'
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
                SizedBox(width: 25,child: LoadingIndicator(indicatorType: Indicator.lineScalePulseOut),),
                Text('No Categories found!', style: TextStyle(color: IKColors.primary),),
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
    // String id = category['_id'];
    String iconUrl = category['icon'] ?? "";

    // return Column(
    //   children: [
    //     ListTile(
    //       onTap: () {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         SubCategoriesScreen(category: category),
    //   ),
    // );
    //       },
    //       leading: iconUrl.isNotEmpty
    //           ? Image.network(
    //               iconUrl,
    //               width: 40,
    //               height: 40,
    //               fit: BoxFit.cover,
    //               errorBuilder: (context, error, stackTrace) =>
    //                   const Icon(Icons.image_not_supported, size: 40),
    //             )
    //           : const Icon(Icons.image_not_supported, size: 40),
    //       title: Text(title, style: const TextStyle(fontSize: 18)),
    //       trailing: const Icon(Icons.arrow_forward_ios),
    //     ),
    //     const Divider(),
    //   ],
    // );

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

