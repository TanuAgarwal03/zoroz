// import 'package:clickcart/components/list/list_item.dart';
// import 'package:flutter/material.dart';

// class SubCategoriesScreen extends StatelessWidget {
//   final Map category;

//   const SubCategoriesScreen({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     String title = category['name']['en'];
//     List children = category['children'] ?? [];

//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: children.isEmpty
//           ? const Center(child: Text("No subcategories available"))
//           : ListView.builder(
//               padding: const EdgeInsets.all(15),
//               itemCount: children.length,
//               itemBuilder: (context, index) {
//                 var subCategory = children[index];
//                 return CategoryItem(category: subCategory);
//               },
//             ),
//     );
//   }
// }

// class CategoryItem extends StatelessWidget {
//   final Map category;

//   const CategoryItem({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     String title = category['name']['en'];
//     String id = category['_id'];
//     String iconUrl = category['icon'] ?? "";
//     bool hasChildren = (category['children'] ?? []).isNotEmpty;

//     return Column(
//       children: [
//         ListItem(
//           onTap: () {
//             if (hasChildren) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SubCategoriesScreen(category: category),
//                 ),
//               );
//             } else {
//               String slug = generateSlug(title);
//               Navigator.pushNamed(
//                 context,
//                 '/products',
//                 arguments: {'slug': slug, 'id': id},
//               );
//             }
//           },
//           icon: iconUrl.isNotEmpty
//               ? Image.network(
//                   iconUrl,
//                   width: 20,
//                   height: 20,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.image_not_supported, size: 20),
//                 )
//               : null,
//           title: title,
//         ),
//         const SizedBox(height: 5),
//       ],
//     );
//   }

//   // Function to generate slug from title
//   String generateSlug(String title) {
//     return title.toLowerCase().replaceAll("&", "").replaceAll(" ", "-");
//   }
// }

import 'package:clickcart/components/list/list_item.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  final Map category;

  const SubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    String title = category['name']['en'];
    String categoryId = category['_id'];
    String categorySlug = generateSlug(title);
    List children = category['children'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: children.length + 1, // +1 for "All" item
        itemBuilder: (context, index) {
          if (index == 0) { // "All" ListItem
            return Column(
              children: [
                ListItem(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/products',
                      arguments: {'slug': categorySlug, 'id': categoryId},
                    );
                  },
                  icon: null,
                  title: "All",
                ),
                const SizedBox(height: 5),
              ],
            );
          }

          var subCategory = children[index - 1]; 
          return CategoryItem(category: subCategory);
        },
      ),
    );
  }

  // Function to generate slug from title
  String generateSlug(String title) {
    return title.toLowerCase().replaceAll("&", "").replaceAll(" ", "-");
  }
}

class CategoryItem extends StatelessWidget {
  final Map category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    String title = category['name']['en'];
    String id = category['_id'];
    String iconUrl = category['icon'] ?? "";
    bool hasChildren = (category['children'] ?? []).isNotEmpty;

    return Column(
      children: [
        ListItem(
          onTap: () {
            if (hasChildren) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategoriesScreen(category: category),
                ),
              );
            } else {
              String slug = generateSlug(title);
              Navigator.pushNamed(
                context,
                '/products',
                arguments: {'slug': slug, 'id': id},
              );
            }
          },
          icon: iconUrl.isNotEmpty
              ? Image.network(
                  iconUrl,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 20),
                )
              : null,
          title: title,
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  String generateSlug(String title) {
    return title.toLowerCase().replaceAll("&", "").replaceAll(" ", "-");
  }
}

