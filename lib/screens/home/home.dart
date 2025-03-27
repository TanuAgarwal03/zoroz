import 'dart:async';
import 'package:clickcart/components/bottomsheet/login_sheet2.dart';
import 'package:clickcart/components/drawer/drawer_menu.dart';
import 'package:clickcart/components/home/banner_swiper.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
// import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  List categories = [];
  List<Map<String, dynamic>> productItems = [];
  List<Map<String, dynamic>> appleproductItems = [];
  List<Map<String, dynamic>> smartWearItems = [];
  List<Map<String, dynamic>> cameraProductItems = [];
  bool isLoading = true;
  final List<String> items = List.generate(20, (index) => 'Item $index');
  String? firstBanner;
  String? secondBanner;
  String? thirdBanner;
  String? fourthBanner;
  String? fifthBanner;
  String? token;

  void loginSheetTime() async {
    Timer(
        const Duration(seconds: 5),
        () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const LoginSheet2();
              },
            ));
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchSamsungProductItems();
    fetchAppleProductItems();
    fetchSmartWearItems();
    fetchCameraProductItems();
    // loginSheetTime();
    fetchSliders();
    fetchLogindetails();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300) {
        setState(() {
          _showBackToTopButton = true;
        });
      } else {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> fetchSliders() async {
    try {
      final url = Uri.parse(
          'https://backend.vansedemo.xyz/api/setting/store/customization/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        // print('Decoded response: $decodedResponse');

        // If it's a list, use [0] to access the first item
        final Map<String, dynamic> data =
            decodedResponse is List ? decodedResponse[0] : decodedResponse;

        if (data.containsKey('slider')) {
          final slider = data['slider'];

          setState(() {
            firstBanner = slider['first_img'];
            secondBanner = slider['second_img'];
            thirdBanner = slider['third_img'];
            fourthBanner = slider['four_img'];
            fifthBanner = slider['five_img'];
          });
        } else {
          print('Slider data missing in response.');
        }
      } else {
        print('Failed to load sliders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sliders: $e');
    }
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

  String generateSlug(String title) {
    return title.toLowerCase().replaceAll("&", "").replaceAll(" ", "-");
  }

  Future<void> fetchSamsungProductItems() async {
    const url =
        'https://store.vansedemo.xyz/_next/data/development/en/search.json?category=samsung-accessories&_id=675acb6b385e83118ac72f63';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final products = data['pageProps']['products'] as List<dynamic>;

        final List<Map<String, dynamic>> loadedProducts =
            products.map((product) {
          final prices = product['prices'];
          final title = product['title']['en'];
          final images = product['image'] as List<dynamic>;

          return {
            'title': title ?? 'No Title',
            // 'image' : images[0],
            'image': images.isNotEmpty
                ? images[0]
                : 'https://img.myipadbox.com/upload/store/product_l/${product['itemNo']}.jpg',
            'price': prices['price'].toString(),
            'old-price': prices['originalPrice'].toString(),
            'offer': '${prices['discount']}',
            'itemNo': product['itemNo'],
            'slug': product['slug']
          };
        }).toList();

        setState(() {
          productItems = loadedProducts;
          isLoading = false;
        });
      } else {
        print('Failed to load products: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchAppleProductItems() async {
    const url =
        'https://store.vansedemo.xyz/_next/data/development/en/search.json?category=apple-accessories&_id=675acb6b385e83118ac72f69';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final appleProducts = data['pageProps']['products'] as List<dynamic>;

        final List<Map<String, dynamic>> appleloadedProducts =
            appleProducts.map((appleProduct) {
          final prices = appleProduct['prices'];
          final title = appleProduct['title']['en'];
          final images = appleProduct['image'] as List<dynamic>;

          return {
            'title': title ?? 'No Title',
            // 'image' : images[0],
            'image': images.isNotEmpty
                ? images[0]
                : 'https://img.myipadbox.com/upload/store/product_l/${appleProduct['itemNo']}.jpg', // Default image,
            'price': prices['price'].toString(),
            'old-price': prices['originalPrice'].toString(),
            'offer': '${prices['discount']}',
            'itemNo': appleProduct['itemNo'],
            'slug': appleProduct['slug']
          };
        }).toList();

        setState(() {
          appleproductItems = appleloadedProducts;
          isLoading = false;
          // print('Loaded Apple Products: $appleloadedProducts');
        });
      } else {
        print('Failed to load products: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchSmartWearItems() async {
    const url =
        'https://store.vansedemo.xyz/_next/data/development/en/search.json?category=smart-wear&_id=675acb6b385e83118ac72f62';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final smartWearProducts =
            data['pageProps']['products'] as List<dynamic>;

        final List<Map<String, dynamic>> smartwearloadedProducts =
            smartWearProducts.map((smartWearProduct) {
          final prices = smartWearProduct['prices'];
          final title = smartWearProduct['title']['en'];
          final images = smartWearProduct['image'] as List<dynamic>;

          return {
            'title': title ?? 'No Title',
            // 'image' : images[0],
            'image': images.isNotEmpty
                ? images[0]
                : 'https://img.myipadbox.com/upload/store/product_l/${smartWearProduct['itemNo']}.jpg', // Default image,
            'price': prices['price'].toString(),
            'old-price': prices['originalPrice'].toString(),
            'offer': '${prices['discount']}',
            'itemNo': smartWearProduct['itemNo'],
            'slug': smartWearProduct['slug']
          };
        }).toList();

        setState(() {
          smartWearItems = smartwearloadedProducts;
          isLoading = false;
        });
      } else {
        print('Failed to load products: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCameraProductItems() async {
    const url =
        'https://store.vansedemo.xyz/_next/data/development/en/search.json?category=camera-accessories&_id=675acb6b385e83118ac72f5e';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final cameraProducts = data['pageProps']['products'] as List<dynamic>;

        final List<Map<String, dynamic>> cameraloadedProducts =
            cameraProducts.map((cameraProduct) {
          final prices = cameraProduct['prices'];
          final title = cameraProduct['title']['en'];
          final images = cameraProduct['image'] as List<dynamic>;

          return {
            'title': title ?? 'No Title',
            // 'image' : images[0],
            'image': images.isNotEmpty
                ? images[0]
                : 'https://img.myipadbox.com/upload/store/product_l/${cameraProduct['itemNo']}.jpg', // Default image,
            'price': prices['price'].toString(),
            'old-price': prices['originalPrice'].toString(),
            'offer': '${prices['discount']}',
            'itemNo': cameraProduct['itemNo'],
            'slug': cameraProduct['slug']
          };
        }).toList();

        setState(() {
          cameraProductItems = cameraloadedProducts;
          isLoading = false;
        });
      } else {
        print('Failed to load products: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() => isLoading = false);
    }
  }

  void fetchLogindetails() async {
    var box = await Hive.openBox('userBox');
    final loginData = box.get('loginData');

    if (loginData != null) {
      token = loginData['token'];
      print('Phone: ${loginData['phone']}');
      print('Token (if available): ${loginData['token']}');
      print('Name : ${loginData['name']}');
      print('Email : ${loginData['email']}');
      print('Id : ${loginData['_id']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: IKSizes.container),
              child: AppBar(
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      iconSize: 28,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                title: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(4), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/images/logo_cropped.png',
                    height: 24,
                    fit: BoxFit
                        .cover, // Ensures the image fits properly within the rounded container
                  ),
                ),
                titleSpacing: 5,
              ),
            ),
          )),
      drawer: const DrawerMenu(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/search_screen');
                      },
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Search products',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BannerSwiper(),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: Text('Trending Categories',
                      style: Theme.of(context).textTheme.headlineMedium),
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The GridView for showing categories (max 9 items shown)
                      GridView.builder(
                        itemCount:
                            categories.length > 9 ? 9 : categories.length,
                        shrinkWrap:
                            true, // Makes it take only the space it needs
                        physics:
                            const NeverScrollableScrollPhysics(), // No scroll, let parent scroll
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          String slug = generateSlug(category['name']['en']);
                          String id = category['_id'];
                          String categoryName = category['name']['en'];

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/products',
                                arguments: {
                                  'slug': slug,
                                  'id': id,
                                  'name': categoryName
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: category['icon'] != null &&
                                            category['icon'].isNotEmpty
                                        ? Image.network(
                                            category['icon'],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Icon(
                                                    Icons.image_not_supported,
                                                    size: 60),
                                          )
                                        : const Icon(Icons.image_not_supported,
                                            size: 60),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(
                                      category['name']['en'] ?? '',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      // Conditionally display the "View More" button if categories > 9
                      if (categories.length > 9)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          color: Theme.of(context).cardColor,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/components');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 236, 97, 97),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'View More',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/products',
                                arguments: {
                                  'slug': 'apple-accessories',
                                  'id': '675acb6b385e83118ac72f69'
                                },
                              );
                            },
                            child: Image.asset(
                                'assets/images/banner/apple_banner.png')),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/products',
                                arguments: {
                                  'slug': 'repair-spare-parts',
                                  'id': '675acb6a385e83118ac72f59'
                                },
                              );
                            },
                            child: Image.asset(
                                'assets/images/banner/repair_banner.png')),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                          child: Text('Samsung Accessories',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: productItems.map((item) {
                              return SizedBox(
                                  width: 162,
                                  child: ProductCard(
                                    slug: item['slug'] ?? 'no slug',
                                    itemNo: item['itemNo'] ?? '',
                                    title: item['title'] ?? '',
                                    image: item['image'].isEmpty
                                        ? "https://img.myipadbox.com/upload/store/product_l/${item['itemNo']}.jpg"
                                        : item['image'],
                                    price: item['price'] ?? '',
                                    oldPrice: item['old-price'] ?? '',
                                    offer: (item['offer']),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    )),
                ServiceList(),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                          child: Text('Apple Accessories',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: appleproductItems.map((item1) {
                              return SizedBox(
                                  width: 162,
                                  child: ProductCard(
                                    slug: item1['slug']!,
                                    itemNo: item1['itemNo']!,
                                    title: item1['title']!,
                                    image: item1['image'].isEmpty
                                        ? "https://img.myipadbox.com/upload/store/product_l/${item1['itemNo']}.jpg"
                                        : item1['image'],
                                    price: item1['price']!,
                                    oldPrice: item1['old-price']!,
                                    offer: (item1['offer']),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/products',
                                arguments: {
                                  'slug': 'smart-phones',
                                  'id': '675acb6b385e83118ac72f61'
                                },
                              );
                            },
                            child: Image.asset(
                                'assets/images/banner/smartphone_banner.png')),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1,
                                color: Theme.of(context).dividerColor))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                          child: Text('Smart Wear',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: smartWearItems.map((item1) {
                              return SizedBox(
                                  width: 162,
                                  child: ProductCard(
                                    slug: item1['slug']!,
                                    itemNo: item1['itemNo']!,
                                    title: item1['title']!,
                                    image: item1['image'].isEmpty
                                        ? "https://img.myipadbox.com/upload/store/product_l/${item1['itemNo']}.jpg"
                                        : item1['image'],
                                    price: item1['price']!,
                                    oldPrice: item1['old-price']!,
                                    offer: (item1['offer']),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 12),
                Image.asset('assets/images/banner/launch.jpg',
                    width: double.infinity),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      child: Text('Camera Accessories',
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    Wrap(
                      children: cameraProductItems.map((item) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width >
                                  IKSizes.container
                              ? IKSizes.container / 3
                              : MediaQuery.of(context).size.width / 2,
                          child: ProductCard(
                            slug: item['slug'] ??
                                'polar-m600-charging-cable-black',
                            itemNo: item['itemNo'] ?? 'IP7G8960B',
                            title: item['title']!,
                            image: item['image']!,
                            price: item['price']!,
                            oldPrice: item['old-price']!,
                            offer: item['offer']!,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: IKColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
    );
  }
}
