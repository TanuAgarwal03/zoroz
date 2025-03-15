import 'package:clickcart/screens/shortcodes/subcategories.dart';
// import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/components/list/list_item.dart';
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
          ? const Center(child: SizedBox(
                          width: 25,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOut,
                          ),
                        ),)
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
                  width: 20, // Adjust size as needed
                  height: 20,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 25),
                )
              : const Icon(Icons.image_not_supported, size: 50),
          title: title,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}



      // body: Container(
      //             color: Theme.of(context).cardColor,
      //             height: 140, // Adjust height to fit two lines of text
      //             child: SingleChildScrollView(
      //               scrollDirection: Axis.horizontal,
      //               child: Row(
      //                 children: categories.map((category) {
      //                   String slug = generateSlug(category['name']['en']);
      //                   String id = category['_id'];
      //                   return GestureDetector(
      //                       onTap: () {
      //                         Navigator.pushNamed(
      //                           context,
      //                           '/products',
      //                           arguments: {'slug': slug, 'id': id},
      //                         );
      //                       },
      //                       child: Padding(
      //                         padding:
      //                             const EdgeInsets.symmetric(horizontal: 10),
      //                         child: Column(
      //                           children: [
      //                             // Text(slug),
      //                             ClipOval(
      //                               child: category['icon'] != null &&
      //                                       category['icon'].isNotEmpty
      //                                   ? Image.network(
      //                                       category['icon'],
      //                                       width: 60, // Adjust size as needed
      //                                       height: 60,
      //                                       fit: BoxFit.cover,
      //                                       errorBuilder: (context, error,
      //                                               stackTrace) =>
      //                                           Icon(Icons.image_not_supported,
      //                                               size: 60),
      //                                     )
      //                                   : Icon(Icons.image_not_supported,
      //                                       size: 60),
      //                             ),
      //                             SizedBox(height: 5),
      //                             SizedBox(
      //                               width:
      //                                   70, // Adjust width for proper text wrapping
      //                               child: Text(
      //                                 category['name']['en'],
      //                                 textAlign: TextAlign.center,
      //                                 style: TextStyle(
      //                                     fontSize: 14,
      //                                     fontWeight: FontWeight.bold),
      //                                 maxLines:
      //                                     2, // Allow text to wrap into 2 lines
      //                                 overflow: TextOverflow
      //                                     .ellipsis, // Show "..." if text is too long
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ));
      //                 }).toList(),
      //               ),
      //             ),
      //           ),

      // body: categories.isNotEmpty
      //     ? const Center(child: CircularProgressIndicator()) // Show loader while data loads
      //     : ListView.builder(
      //         itemCount: categories.length,
      //         itemBuilder: (context, index) {
      //           var category = categories[index];
      //           String title = category['name']['en'];
      //           // String imageUrl = category['image'] ?? ""; // If image is null, use empty string

      //           // Fallback image if 'image' is empty
      //           // if (imageUrl.isEmpty) {
      //           //   imageUrl = "https://img.myipadbox.com/upload/store/product_l/${category['itemNo']}.jpg";
      //           // }

      //           return ListTile(
      //             // leading: Image.network(
      //             //   imageUrl,
      //             //   width: 50,
      //             //   height: 50,
      //             //   fit: BoxFit.cover,
      //             //   errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
      //             // ),
      //             title: Text(title),
      //             subtitle: Text(generateSlug(title)),
      //             trailing: Text('hi'), // Displaying slug as subtitle
      //           );
      //         },
      //       ),

              // Container(
              //   color: Theme.of(context).cardColor,
              //   height: 140,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: categories.map((category) {
                      // String slug = generateSlug(category['name']['en']);
                      // String id = category['_id'];
              //         return GestureDetector(
              //             onTap: () {
              //               Navigator.pushNamed(
              //                 context,
              //                 '/products',
              //                 arguments: {'slug': slug, 'id': id},
              //               );
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 10),
              //               child: Column(
              //                 children: [
              //                   Text(slug),
              //                   ClipOval(
              //                     child: category['icon'] != null &&
              //                             category['icon'].isNotEmpty
              //                         ? Image.network(
              //                             category['icon'],
              //                             width: 60, // Adjust size as needed
              //                             height: 60,
              //                             fit: BoxFit.cover,
              //                             errorBuilder:
              //                                 (context, error, stackTrace) =>
              //                                     const Icon(
              //                                         Icons.image_not_supported,
              //                                         size: 60),
              //                           )
              //                         : const Icon(Icons.image_not_supported,
              //                             size: 60),
              //                   ),
              //                   const SizedBox(height: 5),
              //                   SizedBox(
              //                     width: 70,
              //                     child: Text(
              //                       category['name']['en'],
              //                       textAlign: TextAlign.center,
              //                       style: const TextStyle(
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.bold),
              //                       maxLines:
              //                           2, // Allow text to wrap into 2 lines
              //                       overflow: TextOverflow
              //                           .ellipsis, // Show "..." if text is too long
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ));
              //       }).toList(),
              //     ),
              //   ),
              // ),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/accordion');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.accordion,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Accordion List",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/bottomsheet');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.sheet,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Bottom Sheets",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/modalbox');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.cube,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Modal Box",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/buttons');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.accordion,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Button Styles",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/badges');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.badge,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Badges",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/charts');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.charts,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Charts",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/inputs');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.input,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Inputs",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/lists');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.list,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "List Styles",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/pricings');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.pricing,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Pricings",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/snackbars');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.accordion,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Snackbars",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/socials');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.social,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Socials",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/swipeables');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.accordion,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Swipeable",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/tabs');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.tabs,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Tabs",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/tables');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.table,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Tables",
              // ),
              // const SizedBox(height: 5),
              // ListItem(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/toggle');
              //   },
              //   icon: SvgPicture.string(
              //     IKSvg.toggle,
              //     width: 20,
              //     height: 20,
              //     // ignore: deprecated_member_use
              //     color: IKColors.primary,
              //   ),
              //   title: "Toggle",
              // ),

