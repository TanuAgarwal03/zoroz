import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:clickcart/components/bottomsheet/filter_sheet.dart';
import 'package:clickcart/components/bottomsheet/short_by.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/components/product/product_card_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List products = [];

  bool isLoading = true;
  int page = 1;
  bool isFetchingMore = false;
  late ScrollController _scrollController;
  bool hasMore = true;
  String _currentSort = "Price - Low to High";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !isFetchingMore) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      fetchMoreProducts(args['id']!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    fetchProducts(args['slug']!, args['id']!);
  }

  Future<void> fetchProducts(String slug, String id) async {
    final url = Uri.parse(
        'https://store.vansedemo.xyz/_next/data/development/en/search.json?category=$slug&_id=$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          products = data['pageProps']['products'];
        });
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _applySorting(String sortOption) {
    setState(() {
      if (sortOption == "Price - Low to High") {
        products.sort(
            (a, b) => a['prices']['price'].compareTo(b['prices']['price']));
      } else if (sortOption == "Price - High to Low") {
        products.sort(
            (a, b) => b['prices']['price'].compareTo(a['prices']['price']));
      }
      setState(() {});
      // Debug print
      print("Sorted products: $products");
    });
  }

  Future<void> fetchMoreProducts(String id) async {
    if (!hasMore) {
      print('Blocked: No more products to load (hasMore is false).');
      _applySorting(_currentSort);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final int nextPage = page + 1;
      final String url =
          'https://backend.vansedemo.xyz/api/products/store?category=$id&page=$nextPage&limit=20';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (!responseData.containsKey('products')) {
          print('Error: "products" key missing in response');
          setState(() {
            isLoading = false;
          });
          return;
        }

        final List<dynamic> fetchedProducts = responseData['products'];

        if (fetchedProducts.isEmpty) {
          // print('No products found on page $nextPage.');
          setState(() {
            hasMore = false;
            isLoading = false;
          });
          return;
        }

        setState(() {
          products.addAll(fetchedProducts);
          page = nextPage;
          hasMore = fetchedProducts.length == 20;
          _applySorting(_currentSort);
          isLoading = false;
        });
      } else {
        print('Server error: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Fetch error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String _productView = "grid";

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width > 800
        ? 800 / 3
        : MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: IKSizes.container),
              child: AppBar(
                title: const Text('Product Grid'),
                titleSpacing: 5,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search_screen');
                    },
                    iconSize: 28,
                    icon: SvgPicture.string(IKSvg.search),
                  ),
                  // Stack(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/cart');
                  //       },
                  //       iconSize: 28,
                  //       // ignore: deprecated_member_use
                  //       icon: SvgPicture.string(IKSvg.cart,
                  //           height: 20, width: 20, color: Colors.white),
                  //     ),
                  //     Positioned(
                  //       top: 8,
                  //       right: 8,
                  //       child: Container(
                  //         height: 16,
                  //         width: 16,
                  //         decoration: BoxDecoration(
                  //           color: IKColors.secondary,
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         alignment: Alignment.center,
                  //         child: const Text('14',
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 10)),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: IKSizes.container),
          child: products.isEmpty
              ? const Center(
                  child: SizedBox(
                      width: 25,
                      child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOut)))
              : Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        /// SORT SECTION - HALF WIDTH
                        Expanded(
                          flex: 1, // 50% space
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShortBy(
                                    initialSelectedValue: _currentSort,
                                    onSortSelected: (selectedSort) {
                                      setState(() {
                                        _currentSort = selectedSort;
                                      });
                                      _applySorting(_currentSort);
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 9),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.string(IKSvg.sort),
                                  const SizedBox(width: 5),
                                  Text(
                                    'SORT',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.merge(
                                          const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _productView = 'list';
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                      ),
                                    ),
                                    child: SvgPicture.string(
                                      IKSvg.list,
                                      width: 20,
                                      height: 20,
                                      color: _productView == "list"
                                          ? IKColors.primary
                                          : Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color,
                                    ),
                                  ),
                                ),
                              ),

                              /// GRID VIEW BUTTON
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _productView = 'grid';
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.string(
                                      IKSvg.grid,
                                      width: 20,
                                      height: 20,
                                      color: _productView == "grid"
                                          ? IKColors.primary
                                          : Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              // Spread operator to map product list
                              ...products.map((product) {
                                String imageUrl = product['image'].isNotEmpty
                                    ? product['image'][0]
                                    : "https://img.myipadbox.com/upload/store/product_l/${product['itemNo']}.jpg";

                                return SizedBox(
                                  width: _productView == "list"
                                      ? null
                                      : containerWidth,
                                  child: _productView == "list"
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: ProductCardList(
                                            title: product['title']['en'] ?? '',
                                            price: product['prices']['price']
                                                .toString(),
                                            oldPrice: product['prices']
                                                    ['originalPrice']
                                                .toString(),
                                            image: imageUrl,
                                            returnday: "7 Days",
                                            count: "count",
                                            offer: product['prices']['discount']
                                                .toString(),
                                            reviews: "100+ Reviews",
                                          ),
                                        )
                                      : ProductCard(
                                          slug: product['slug'] ??
                                              'polar-m600-charging-cable-black',
                                          itemNo:
                                              product['itemNo'] ?? 'IP7G8960B',
                                          title: product['title']['en'] ?? '',
                                          image: imageUrl,
                                          price: product['prices']['price']
                                              .toString(),
                                          oldPrice: product['prices']
                                                  ['originalPrice']
                                              .toString(),
                                          offer: product['prices']['discount']
                                              .toString(),
                                        ),
                                );
                              }),

                              // Show loading indicator when fetching more products
                              if (isFetchingMore)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: LoadingIndicator(
                                      indicatorType:
                                          Indicator.lineScalePulseOut,
                                      colors: [Colors.blue],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )

                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     controller: _scrollController,
                  //     child: Wrap(
                  //       children:
                  //       products.map((product) {
                  //         String imageUrl = product['image'].isNotEmpty
                  //             ? product['image'][0]
                  //             : "https://img.myipadbox.com/upload/store/product_l/${product['itemNo']}.jpg";

                  //         // final bool status =
                  //         //     product.containsKey('isCustomProduct')
                  //         //         ? (product['isCustomProduct'] ?? false)
                  //         //         : false;
                  //         return SizedBox(
                  //           width: _productView == "list"
                  //               ? null
                  //               : containerWidth,
                  //           child: _productView == "list"
                  //               ? Padding(
                  //                   padding:
                  //                       const EdgeInsets.only(bottom: 10.0),
                  //                   child: ProductCardList(
                  //                     title: product['title']['en'],
                  //                     price: product['prices']['price']
                  //                         .toString(),
                  //                     oldPrice: product['prices']
                  //                             ['originalPrice']
                  //                         .toString(),
                  //                     image: imageUrl,
                  //                     returnday: "7 Days",
                  //                     count: "count",
                  //                     offer: product['prices']['discount']
                  //                         .toString(),
                  //                     reviews: "100+ Reviews",
                  //                   ),
                  //                 )
                  //               : ProductCard(
                  //                   slug: product['slug'] ??
                  //                       'polar-m600-charging-cable-black',
                  //                   itemNo: product['itemNo'] ?? 'IP7G8960B',
                  //                   title: product['title']['en'],
                  //                   image: imageUrl,
                  //                   price:
                  //                       product['prices']['price'].toString(),
                  //                   oldPrice: product['prices']
                  //                           ['originalPrice']
                  //                       .toString(),
                  //                   offer: product['prices']['discount']
                  //                       .toString(),
                  //                 ),
                  //         );
                  //       }).toList()

                  //     ),
                ]),
        ),
      ),
    );
  }
}
