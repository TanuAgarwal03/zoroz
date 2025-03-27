import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
// import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  Future<void> searchProducts(String searchValue) async {
    if (searchValue.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final results = await fetchSearchResults(searchValue);

    setState(() {
      searchResults = results;
      isLoading = false;
    });
  }

  Future<List<dynamic>> fetchSearchResults(String searchValue) async {
    final String url =
        'https://backend.vansedemo.xyz/api/products/store?title=$searchValue';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming the JSON you provided
        final List<dynamic> products = data['products'];
        return products;
      } else {
        print('Failed to load products');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: IKColors.primary,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Theme.of(context).cardColor,
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    searchProducts(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Best items for You',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    contentPadding: const EdgeInsets.all(18),
                    prefixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchProducts(_searchController.text);
                        },
                        icon: Icon(Icons.search)),
                    suffixIconColor: IKColors.primary,
                    hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).dividerColor, width: 2.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: IKColors.primary, width: 2.0),
                    ),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                ),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                              width: 25,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScalePulseOut,
                              )))
                      : searchResults.isEmpty
                          ?  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/no_results.png',
                                  height: 200,
                                  width: 250,
                                ),
                                const Text(
                                  'No results found',
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final product = searchResults[index];
                                final title = product['title']['en'];
                                final price = product['prices']['originalPrice']
                                    .toString();
                                final itemNo = product['itemNo'];
                                final slug = product['slug'];
                                final imageList =
                                    product['image'] as List<dynamic>;
                                final imageUrl = imageList.isNotEmpty
                                    ? imageList[0] as String
                                    : "https://via.placeholder.com/150";

                                return ListTile(
                                  leading: Image.network(
                                      imageList.isNotEmpty
                                    ? imageList[0] as String :"https://img.myipadbox.com/upload/store/product_l/$itemNo.jpg"),
                                  title: Text(title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  subtitle: Text('Price: ₹${price.toString()}'),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/product_detail',
                                        arguments: ScreenArguments(
                                            title,
                                            imageUrl,
                                            price,
                                            price,
                                            price,
                                            itemNo,
                                            slug));
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
