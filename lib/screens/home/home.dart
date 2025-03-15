import 'dart:async';
import 'package:clickcart/components/bottomsheet/login_sheet2.dart';
import 'package:clickcart/components/drawer/drawer_menu.dart';
import 'package:clickcart/components/home/banner_swiper.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    loginSheetTime();
    fetchSliders();
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
                : 'https://img.myipadbox.com/upload/store/product_l/${product['itemNo']}.jpg', // Default image,
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
                title: Image.asset(
                  'assets/images/applogo.png',
                  height: 30,
                ),
                titleSpacing: 5,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search_screen');
                    },
                    iconSize: 28,
                    icon: SvgPicture.string(IKSvg.search),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/notifications');
                  //   },
                  //   iconSize: 28,
                  //   // ignore: deprecated_member_use
                  //   icon: SvgPicture.string(IKSvg.bell, color: Colors.white),
                  // ),
                ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                BannerSwiper(),
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  height: 140, 
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        String slug = generateSlug(category['name']['en']);
                        String id = category['_id'];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/products',
                                arguments: {'slug': slug, 'id': id},
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  ClipOval(
                                    child: category['icon'] != null &&
                                            category['icon'].isNotEmpty
                                        ? Image.network(
                                            category['icon'],
                                            width: 60, // Adjust size as needed
                                            height: 60,
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
                                  SizedBox(
                                    width: 70,
                                    child: Text(
                                      category['name']['en'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }).toList(),
                    ),
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
                      // const SizedBox(width: 6),
                      // Expanded(
                      //   child: GestureDetector(
                      //       onTap: () {
                      //         Navigator.pushNamed(context, '/products');
                      //       },
                      //       child: Image.asset(IKImages.banner3)),
                      // ),
                      // Expanded(),
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
                // const BlockbusterDeals(),
                const SizedBox(height: 12),
                Image.asset('assets/images/banner/launch.jpg', width: double.infinity),
                // const HomeDecor(),
                // SponserdList(),
                // CategoryList(),
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
    );
  }
}

// class OfferCountdown extends StatefulWidget {
//   const OfferCountdown({super.key});

//   @override
//   State<OfferCountdown> createState() => _OfferCountdownState();
// }

// class _OfferCountdownState extends State<OfferCountdown> {
//   late final StreamDuration _streamDuration;

//   @override
//   void initState() {
//     super.initState();
//     _streamDuration = StreamDuration(
//       config: const StreamDurationConfig(
//         countDownConfig: CountDownConfig(
//           duration: Duration(days: 1),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _streamDuration.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SlideCountdownSeparated(
//           streamDuration: _streamDuration,
//           style: const TextStyle(
//               color: IKColors.title, fontSize: 13, fontWeight: FontWeight.w500),
//           separatorStyle: const TextStyle(
//               color: IKColors.primary, fontWeight: FontWeight.w500),
//           padding: const EdgeInsets.only(left: 5, right: 5, bottom: 1, top: 1),
//           decoration: const BoxDecoration(
//             color: IKColors.secondary,
//             borderRadius: BorderRadius.all(Radius.circular(4)),
//           ),
//         ),
//       ],
//     );
//   }
// }
