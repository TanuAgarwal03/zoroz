import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clickcart/components/bottomsheet/filter_sheet.dart';
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
      // Close to bottom & not already fetching
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

  Future<void> fetchMoreProducts(String id) async {
    if (!hasMore) {
      print('Blocked: No more products to load (hasMore is false).');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final int nextPage = page + 1;
      final String url =
          'https://backend.vansedemo.xyz/api/products/store?category=$id&page=$nextPage&limit=20';

      // print('Fetching products from: $url');

      final response = await http.get(Uri.parse(url));

      // print('Response Status Code: ${response.statusCode}');
      // print('Raw Response Body: ${response.body}');

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

        // print('Fetched ${fetchedProducts.length} products on page $nextPage');

        setState(() {
          products.addAll(fetchedProducts);
          page = nextPage;
          // 🔧 adjust based on backend behavior
          hasMore = fetchedProducts.length == 20;
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
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        iconSize: 28,
                        // ignore: deprecated_member_use
                        icon: SvgPicture.string(IKSvg.cart,
                            height: 20, width: 20, color: Colors.white),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: IKColors.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: const Text('14',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: IKSizes.container),
          child: products.isEmpty
              ?  const Center(child: SizedBox(
                width: 25,
                child: LoadingIndicator(indicatorType: Indicator.lineScalePulseOut)
              ))
              : Column(
                  children: [
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
                      child: Row(children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const ShortBy();
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
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.string(
                                    IKSvg.sort,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('SORT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.merge(const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return const FilterSheet();
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
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.string(
                                    IKSvg.filter,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('FILTER',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.merge(const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)))
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
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
                                        color:
                                            Theme.of(context).dividerColor))),
                            child: SvgPicture.string(
                              IKSvg.list,
                              width: 20,
                              height: 20,
                              // ignore: deprecated_member_use
                              color: _productView == "list"
                                  ? IKColors.primary
                                  : Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                            ),
                          ),
                        ),
                        GestureDetector(
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
                              // ignore: deprecated_member_use
                              color: _productView == "grid"
                                  ? IKColors.primary
                                  : Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Wrap(
                          children: products.map((product) {
                            String imageUrl = product['image'].isNotEmpty
                                ? product['image'][0]
                                : "https://img.myipadbox.com/upload/store/product_l/${product['itemNo']}.jpg";
                            return SizedBox(
                              width: _productView == "list"
                                  ? null
                                  : containerWidth,
                              child: _productView == "list"
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: ProductCardList(
                                        title: product['title']['en'],
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
                                      itemNo: product['itemNo'] ?? 'IP7G8960B',
                                      title: product['title']['en'],
                                      image: imageUrl,
                                      price:
                                          product['prices']['price'].toString(),
                                      oldPrice: product['prices']
                                              ['originalPrice']
                                          .toString(),
                                      offer: product['prices']['discount']
                                          .toString(),
                                    ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    if (isFetchingMore)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 25,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOut,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
