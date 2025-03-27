import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_share/social_share.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Map<String, dynamic>> priceList = [];
  List<Map<String, dynamic>> optionListItems = [];
  List<Map<String, dynamic>> colorListItem = [];
  String sku = '';
  String? unitWeight;
  String? packWeight;
  int? unitWidth;
  int? unitHeight;
  int? unitLength;
  int? packLength;
  int? packHeight;
  int? packWidth;
  int? packQty;
  int _quantity = 1;
  int? price;
  bool isLoading = true;
  Map<String, dynamic>? productDetail;
  Map<String, dynamic>? alloptionListData;
  Map<String, dynamic>? allModelListData;
  List<String> productImages = [];
  String productDescription = '';
  List<dynamic> alloptionList = [];
  List<dynamic> allModelList = [];
  Map<String, dynamic> productData = {};
  List<Map<String, dynamic>> cartItems = [];
  int cartCount = 0;
  String? token;
  bool status = false;
  bool customStatus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProductDetail();
      fetchCartCount();
      fetchLogindetails();
    });
  }

  void shareProduct(String title) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    String productUrl = "'https://store.vansedemo.xyz/product/${args.slug}";

    String shareText = "Check out this product!\n\n"
        "🛍️ *$title*\n"
        "🔗 View Product: $productUrl";

    SocialShare.shareOptions(shareText);
  }

  Future<void> _fetchProductDetail() async {
    setState(() {
      isLoading = true;
    });
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    const String apiUrl =
        'https://backend.vansedemo.xyz/api/products/details/productDetail';

    try {
      print(
          'Fetching product details for itemNo: ${args.itemNo}, slug: ${args.slug}');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'itemNo': args.itemNo,
          'slug': args.slug,
        }),
      );
      print('Response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          productDetail = data['productDetail'];
          print(productDetail);
          alloptionList = data['alloptionListData'];
          allModelList = data['allmodelListData'];

          if (productDetail != null) {
            if (productDetail!.containsKey('optionListItems') &&
                productDetail!['optionListItems'] != null) {
              optionListItems = List<Map<String, dynamic>>.from(
                  productDetail!['optionListItems']);
            } else {
              print('OptionListItems is null or not working');
            }

            if (productDetail!.containsKey('description') &&
                productDetail!['description'] != null &&
                productDetail!['description'].containsKey('en')) {
              productDescription = productDetail!['description']['en'] ??
                  'No description available';
            } else {
              print('Description not found');
              productDescription = 'No description available';
            }

            if (productDetail!.containsKey('modelList') &&
                productDetail!['modelList'] != null) {
              colorListItem =
                  List<Map<String, dynamic>>.from(productDetail!['modelList']);
            } else {
              print('modelList is null or not working');
            }

            if (productDetail!['image'] != null) {
              productImages = List<String>.from(productDetail!['image']);
              print('Fetched Images: $productImages');
            } else {
              print('No images found in productDetail');
            }

            if (productDetail!.containsKey('isCustomProduct')) {
              customStatus = productDetail!['isCustomProduct'];
              print('isCustomProduct = $customStatus');
            }

            productDescription =
                productDetail!['description']['en'] ?? 'No description';
            sku = productDetail!['sku'];
            price = productDetail!['prices']['price'];
            unitHeight = productDetail!['unitHeight'] ?? 0;
            unitLength = productDetail!['unitLength'] ?? 0;
            unitWidth = productDetail!['unitWidth'] ?? 0;
            unitWeight = productDetail!['unitWeight'] ?? '0';
            packHeight = productDetail!['packHeight'] ?? 0;
            packLength = productDetail!['packLength'] ?? 0;
            packWidth = productDetail!['packWidth'] ?? 0;
            packWeight = productDetail!['packWeight'] ?? '0';
            packQty = productDetail!['packQty'] ?? 0;
          }
          if (productDetail!.containsKey('priceList') &&
              productDetail!['priceList'] != null) {
            priceList =
                List<Map<String, dynamic>>.from(productDetail!['priceList']);
          } else {
            print('No priceList found in productDetail');
          }
          setState(() {
            isLoading = false;
          });
          productData = productDetail!;
          return data['productDetail'];
        } else {
          print('API Error: ${data['message']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void fetchLogindetails() async {
    var box = await Hive.openBox('userBox');
    final loginData = box.get('loginData');

    if (loginData != null) {
      token = loginData['token'] ??
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2RhNTk0ZTAxZDgxOGI1OWEyMjlkODQiLCJuYW1lIjoiVGFudSIsInBob25lIjoiODU2MjgwNTIyOCIsImlhdCI6MTc0MjM2NzE0NCwiZXhwIjoxNzQyMzY3MjA0fQ.NGvO6VUx7i8qlZp7SKKhj1_123BvWxDTDAYw0Aunquk';

      setState(() {});
    }
  }

  Future<void> addToCart() async {
    final url = Uri.parse('https://backend.vansedemo.xyz/api/cart/add');

    final cartBox = Hive.box('cartBox');

    final existingCartRaw = cartBox.get('cart', defaultValue: {
      "items": [],
      "isEmpty": true,
      "cartTotal": 0.0,
      "totalItems": 0,
      "totalUniqueItems": 0
    });

    Map<String, dynamic> existingCart =
        Map<String, dynamic>.from(existingCartRaw);

    List<dynamic> rawItems = existingCart['items'];
    List<Map<String, dynamic>> items =
        rawItems.map((e) => Map<String, dynamic>.from(e)).toList();
    int existingProductIndex =
        items.indexWhere((item) => item['_id'] == productData['_id']);

    if (existingProductIndex != -1) {
      items[existingProductIndex]['quantity'] =
          (items[existingProductIndex]['quantity'] ?? 1) + _quantity;
    } else {
      Map<String, dynamic> newProduct = Map<String, dynamic>.from(productData);
      newProduct['quantity'] = _quantity;
      items.add(newProduct);
    }

    double newCartTotal =
        (existingCart['cartTotal'] as num).toDouble() + (price! * _quantity);
    int newTotalItems = (existingCart['totalItems'] as int) + _quantity;
    int newTotalUniqueItems = items.length;
    existingCart['items'] = items;
    existingCart['isEmpty'] = items.isEmpty;
    existingCart['cartTotal'] = newCartTotal;
    existingCart['totalItems'] = newTotalItems;
    existingCart['totalUniqueItems'] = newTotalUniqueItems;
    await cartBox.put('cart', existingCart);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(existingCart),
      );
      if (response.statusCode == 200) {
        setState(() {
          cartItems.add(productData);
          cartCount += _quantity;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            content: const Text(
              'Item added to cart successfully!',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.redAccent,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            duration: const Duration(seconds: 5),
          ),
        );

        print('✅ Item added to cart: ${response.body}');
      } else {
        setState(() => isLoading = false);
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ?? '';

        if (errorMessage.toLowerCase() == 'jwt expired') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Session Expired'),
              content: const Text(
                  'Login token expired. Please login again to continue.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/signin');
                  },
                  child: const Text('OK'),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
            ),
          );
        }
        print('❌ Failed to add item: ${response.statusCode}');
        // print(response.body);
      }
    } catch (error) {
      setState(() => isLoading = false);
      print('❌ Error: $error');
    }
  }

  Future<void> addBulkItemsToCart(Map<int, int> quantities) async {
    final url = Uri.parse('https://backend.vansedemo.xyz/api/cart/add');
    final cartBox = Hive.box('cartBox');
    // Retrieve existing cart and cast to Map<String, dynamic>
    final existingCartRaw = cartBox.get('cart', defaultValue: {
      "items": [],
      "isEmpty": true,
      "cartTotal": 0.0,
      "totalItems": 0,
      "totalUniqueItems": 0
    });
    Map<String, dynamic> existingCart =
        Map<String, dynamic>.from(existingCartRaw);
    List<dynamic> rawItems = existingCart['items'];
    List<Map<String, dynamic>> items =
        rawItems.map((e) => Map<String, dynamic>.from(e)).toList();
    double newCartTotal = (existingCart['cartTotal'] as num).toDouble();
    int newTotalItems = (existingCart['totalItems'] as int);
    int newTotalUniqueItems = items.length;
    bool addedAtLeastOne = false;
    quantities.forEach((index, qty) {
      if (qty > 0) {
        addedAtLeastOne = true;
        final item = (allModelList.isNotEmpty)
            ? allModelList[index]
            : alloptionList[index];
        int existingProductIndex = items
            .indexWhere((existingItem) => existingItem['id'] == item['id']);
        double price = (item['prices']['originalPrice'] as num).toDouble();
        if (existingProductIndex != -1) {
          items[existingProductIndex]['quantity'] =
              (items[existingProductIndex]['quantity'] ?? 1) + qty;
        } else {
          Map<String, dynamic> newProduct = Map<String, dynamic>.from(item);
          newProduct['quantity'] = qty;
          items.add(newProduct);
        }
        newCartTotal += price * qty;
        newTotalItems += qty;
        newTotalUniqueItems = items.length;
        print(
            '🛒 Added item: ${item['title']['en']} (Qty: $qty) Price: ₹$price');
      }
    });
    if (!addedAtLeastOne) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('❌ Please select at least one item to add to cart.'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.redAccent,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }
    // Update existing cart
    existingCart['items'] = items;
    existingCart['isEmpty'] = items.isEmpty;
    existingCart['cartTotal'] = newCartTotal;
    existingCart['totalItems'] = newTotalItems;
    existingCart['totalUniqueItems'] = newTotalUniqueItems;
    await cartBox.put('cart', existingCart);
    // print('🗄️ Updated Cart After Bulk Add: $existingCart');
    // Send the updated cart to the backend
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token" // your token
        },
        body: jsonEncode(existingCart),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('✅ Items added to cart successfully!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.redAccent,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            duration: const Duration(seconds: 5),
          ),
        );
        // print('✅ Bulk items added to cart: ${response.body}');/
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('❌ Failed to add items (${response.statusCode})'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
        print('❌ Failed to add items: ${response.statusCode}');
        // print(response.body);
      }
    } catch (error) {
      print('❌ Error: $error');
    }
  }

  Future<void> fetchCartCount() async {
    try {
      final response = await http.post(
        Uri.parse('https://backend.vansedemo.xyz/api/cart/getCart'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final cartData = jsonDecode(response.body);
        if (cartData['status'] == true) {
          final allCartItems = cartData['allCartItems'];
          setState(() {
            cartCount = allCartItems['totalItems'];
          });
        } else {
          print('❌ Failed to fetch cart count');
        }
      }
    } catch (error) {
      print('❌ Error fetching cart count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: IKSizes.container),
              child: AppBar(
                title: const Text('Product Detail'),
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
                  //       icon: SvgPicture.string(IKSvg.cart,
                  //           // ignore: deprecated_member_use
                  //           height: 20,
                  //           width: 20,
                  //           color: Colors.white),
                  //     ),
                  //     if (cartCount > 0)
                  //       Positioned(
                  //         right: 8,
                  //         top: 8,
                  //         child: Container(
                  //           height: 16,
                  //           width: 16,
                  //           decoration: BoxDecoration(
                  //             color: const Color.fromARGB(255, 255, 238, 238),
                  //             borderRadius: BorderRadius.circular(8),
                  //           ),
                  //           child: Text(
                  //             '$cartCount',
                  //             style: const TextStyle(
                  //               color: Colors.red,
                  //               fontSize: 12,
                  //             ),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Theme.of(context).cardColor,
                      constraints: const BoxConstraints(
                        minHeight: 174,
                        maxHeight: 350,
                      ),
                      height: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          productImages.isEmpty
                              ? Center(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: double.infinity,
                                      height: 300,
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                  ),
                                )
                              : Swiper(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(30),
                                      child: Image.network(
                                        productImages[index],
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                  autoplay: true,
                                  itemCount: productImages.length,
                                  pagination: const SwiperPagination(
                                    builder: DotSwiperPaginationBuilder(
                                      size: 8,
                                      activeSize: 8,
                                      color: Color.fromARGB(36, 40, 117, 240),
                                      activeColor: IKColors.primary,
                                      space: 4,
                                    ),
                                  ),
                                ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: IconButton(
                              onPressed: () {
                                shareProduct(args.title);
                                // SocialShare.shareOptions(
                                //     'Check out this product! ${args.title}');
                              },
                              iconSize: 20,
                              icon: SvgPicture.string(
                                IKSvg.share,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(args.title,
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      (customStatus == true)
                                          ? 'Rs. $price'
                                          : 'Rs. ${_getPrice().toStringAsFixed(0)}.00',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.merge(const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: IKColors.primary))),
                                  const SizedBox(width: 6),
                                  (args.offer == '0')
                                      ? const Text('')
                                      : Text('₹${args.oldPrice}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.merge(TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color))),
                                  const SizedBox(width: 10),
                                  // (args.offer == '0')
                                  //     ? const Text('')
                                  //     : Text('₹${args.offer}',
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .titleMedium
                                  //             ?.merge(const TextStyle(
                                  //                 color: IKColors.danger))),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              (isLoading)
                                  ? Container(
                                      width: 150,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    )
                                  : (sku != '')
                                      ? Text(
                                          'Item #: $sku',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      : const SizedBox.shrink(),
                              const SizedBox(height: 10),
                              if (isLoading)
                                Container(
                                  width: 200,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                )
                              else if (optionListItems.isNotEmpty)
                                const Row(
                                  children: [
                                    Text(
                                      'Options : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              if (isLoading)
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              else
                                _buildOptionList(),
                              SizedBox(height: 10),
                              if (isLoading)
                                Container(
                                  width: 250,
                                  height: 16,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                )
                              else if (colorListItem.isNotEmpty)
                                const Row(
                                  children: [
                                    Text(
                                      'Same model in different Color : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              if (isLoading)
                                Container(
                                  width: double.infinity,
                                  height: 80,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              else
                                _buildColorList(),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                'Quantity :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              _buildQuantitySelector(),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isLoading
                                    ? Container(
                                        width:
                                            100, // 👈 Set a consistent width here
                                        height:
                                            16, // 👈 Height similar to the Text widget's line height
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      )
                                    : const Text(
                                        'Price List',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              16, // 👈 Match the height to this font size
                                        ),
                                      ),
                                const SizedBox(height: 5),
                                isLoading
                                    ? Container(
                                        width: double.infinity,
                                        height:
                                            150, // 👈 Approximate height for the price table shimmer
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      )
                                    : _buildVerticalPriceTable(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ServiceList(vertical: true),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Description:',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 6),
                          Text(
                              productDescription.isNotEmpty
                                  ? productDescription
                                  : 'No description available',
                              // 'sadad',
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Theme.of(context).cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('Specifications:',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          const SizedBox(height: 6),
                          _buildSpecification(
                            'One Package Weight',
                            (unitWeight != null &&
                                    unitWeight.toString().isNotEmpty)
                                ? '$unitWeight kgs'
                                : '--',
                          ),
                          _buildSpecification(
                            'One Package Size',
                            (unitLength != null &&
                                    unitWidth != null &&
                                    unitHeight != null)
                                ? '${unitLength}cm * ${unitWidth}cm * ${unitHeight}cm'
                                : '--',
                          ),

                          _buildSpecification(
                            'Qty per Carton',
                            (packQty != null && packQty.toString().isNotEmpty)
                                ? packQty.toString()
                                : '--',
                          ),

                          _buildSpecification(
                            'Carton Weight',
                            (packWeight != null &&
                                    packWeight.toString().isNotEmpty)
                                ? '$packWeight kgs'
                                : '--',
                          ),

                          _buildSpecification(
                            'Carton Size',
                            (packLength != null &&
                                    packWidth != null &&
                                    packHeight != null &&
                                    packLength.toString().isNotEmpty &&
                                    packWidth.toString().isNotEmpty &&
                                    packHeight.toString().isNotEmpty)
                                ? '${packLength}cm * ${packWidth}cm * ${packHeight}cm'
                                : '--',
                          ),

                          // _buildSpecification('One Package Size',
                          //     '${unitLength}cm*${unitWidth}cm*${unitHeight}cm'),
                          // _buildSpecification(
                          //     'Qty per Carton', packQty?.toString() ?? 'N/A'),
                          // _buildSpecification(
                          //     'Carton Weight', '$packWeight kgs'),
                          // _buildSpecification('Carton Size',
                          //     '${packLength.toString()}cm*${packWidth.toString()}cm*${packHeight.toString()}cm'),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
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
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        addToCart();
                        Navigator.pushNamed(context, '/cart');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text('Add To Cart',
                          style: TextStyle(
                              color: IKColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    )),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        _showBulkBuyPopupWithTabs(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: IKColors.secondary,
                        side: const BorderSide(color: IKColors.secondary),
                      ),
                      child: const Text('Buy in Bulk',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionList() {
    if (optionListItems.isEmpty) {
      return Center(
        child: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      );
    }
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: optionListItems.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final optionItem = optionListItems[index];
          final itemNo = optionItem['itemNo'];

          return GestureDetector(
              onTap: () {
                _sendPostRequest(context, itemNo);
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Center(
                  child: Text(
                    '${optionItem['keywords']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _buildColorList() {
    if (colorListItem.isEmpty) {
      return Center(
        child: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      );
    }
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemCount: colorListItem.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final optionItem = colorListItem[index];
          final itemNo = optionItem['key'];
          final imageUrl = optionItem['imageUrl'];
          status = optionItem.containsKey('isCustomProduct')
              ? (optionItem['isCustomProduct'] ?? false)
              : false;

          return GestureDetector(
            onTap: () {
              _sendPostRequest(context, itemNo);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border:
                    Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
              ),
              child: Image.network(
                status
                    ? imageUrl
                    : 'https://img.myipadbox.com/upload/store/product_l/$itemNo.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _sendPostRequest(BuildContext context, String itemNo) async {
    final url = Uri.parse(
        "https://backend.vansedemo.xyz/api/products/optionList/productModel");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "itemNo": itemNo,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          print("status true: $responseData");
        }
        // print("Success: $responseData");

        final productItem = responseData['productItem'];
        final slug = productItem['slug'];
        final returnedItemNo = productItem['itemNo'];
        final title = productItem['title']['en'] ?? 'No title';
        final images = productItem['image'];
        final firstImage = images.isNotEmpty
            ? images[0]
            : 'https://img.myipadbox.com/upload/store/product_l/$returnedItemNo.jpg';
        final price = productItem['prices']['price'].toString();
        final oldPrice = productItem['prices']['originalPrice'].toString();
        final offer = productItem['prices']['discount'].toString();

        print("Slug: $slug");
        print("ItemNo: $returnedItemNo");

        Navigator.pushNamed(
          context,
          '/product_detail',
          arguments: ScreenArguments(
              title, firstImage, price, oldPrice, offer, returnedItemNo, slug),
        );
      } else {
        print("Failed with status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Widget _buildVerticalPriceTable() {
    if (priceList.isEmpty) {
      return Center(
        child: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
              )
            : const Text("No price list available"),
      );
    }

    final selectedIndex = getSelectedIndexFromQuantity(_quantity);

    return Container(
      // margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
            },
            border: TableBorder.all(color: Colors.grey.shade400),
            children: [
              ...priceList.asMap().entries.map((entry) {
                final index = entry.key;
                final priceItem = entry.value;
                final isSelected = index == selectedIndex;
                return TableRow(
                  decoration: BoxDecoration(
                    color: isSelected
                        // ? const Color.fromARGB(255, 240, 216, 180)
                        ? const Color.fromRGBO(253, 194, 106, 1)
                        : Colors.white,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: Center(
                        child: Text(
                          '${priceItem['key']}+ units',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: Center(
                        child: Text(
                          customStatus
                              ? 'Rs.${(double.parse(priceItem['value'])).toStringAsFixed(0)}'
                              : 'Rs.${(double.parse(priceItem['value']) * 85).toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecification(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.merge(const TextStyle(fontWeight: FontWeight.w500))),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.merge(const TextStyle(fontWeight: FontWeight.w400)))),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (_quantity > 1) _quantity--;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              child: const Icon(
                Icons.remove,
                size: 20,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: Text(
              '$_quantity',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _quantity++;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Icon(Icons.add, size: 15),
            ),
          ),
        ],
      ),
    );
  }

  int getSelectedIndexFromQuantity(int quantity) {
    if (quantity <= 1) {
      return 0;
    } else if (quantity >= 2 && quantity <= 10) {
      return 1;
    } else if (quantity >= 11 && quantity <= 20) {
      return 2;
    } else if (quantity >= 21 && quantity <= 50) {
      return 3;
    } else if (quantity >= 51 && quantity <= 100) {
      return 4;
    } else if (quantity >= 101 && quantity <= 200) {
      return 5;
    } else {
      return 6; // quantity > 200
    }
  }

  int _getPriceIndex() {
    if (_quantity <= 1) {
      return 0;
    } else if (_quantity >= 2 && _quantity <= 10) {
      return 1;
    } else if (_quantity >= 11 && _quantity <= 20) {
      return 2;
    } else if (_quantity >= 21 && _quantity <= 50) {
      return 3;
    } else if (_quantity >= 51 && _quantity <= 100) {
      return 4;
    } else if (_quantity >= 101 && _quantity <= 200) {
      return 5;
    } else {
      return priceList.length - 1;
    }
  }

  double _getPrice() {
    int index = _getPriceIndex();
    if (priceList.isEmpty) {
      debugPrint('Price list is empty');
      return 0.0;
    }
    if (index < 0 || index >= priceList.length) {
      debugPrint('Invalid index returned from _getPriceIndex(): $index');
      index = 0;
    }
    double priceValue =
        double.tryParse(priceList[index]['value'].toString()) ?? 0.0;
    return priceValue * 85;
  }

  void _showBulkBuyPopupWithTabs(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        final double sheetHeight = MediaQuery.of(context).size.height * 0.7;

        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: SizedBox(
              height: sheetHeight,
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TabBar(
                            labelColor: Colors.red,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.red,
                            tabs: [
                              Tab(text: "Color Variant"),
                              Tab(text: "Model Variant"),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _bulkBuyModelContent(context),
                        _bulkBuyOptionsContent(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bulkBuyModelContent(BuildContext context) {
    Map<int, int> quantities = {};

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text('Color',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text('Price',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text('Qty',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 1,
                              child: Text('Amount',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const Divider(),
                      allModelList.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allModelList.length,
                              itemBuilder: (context, index) {
                                final item = allModelList[index];
                                final itemNo = item['itemNo'];
                                final title = item['title']['en'];
                                final int originalPrice =
                                    item['prices']['price'];

                                quantities[index] = quantities[index] ?? 0;

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    int quantity = quantities[index]!;
                                    int amount = quantity * originalPrice;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  child: Image.network(
                                                    'https://img.myipadbox.com/upload/store/product_l/$itemNo.jpg',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Icon(Icons.image),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 1,
                                                child: Text('₹$originalPrice',
                                                    style: const TextStyle(
                                                        color: Colors.red)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.remove),
                                                      iconSize: 12,
                                                      onPressed: () {
                                                        if (quantity > 0) {
                                                          setState(() {
                                                            quantities[index] =
                                                                quantity - 1;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    Text('$quantity'),
                                                    IconButton(
                                                      icon:
                                                          const Icon(Icons.add),
                                                      iconSize: 12,
                                                      onPressed: () {
                                                        setState(() {
                                                          quantities[index] =
                                                              quantity + 1;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    '₹${amount.round()}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          Text(title),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: Text('No items available',
                                  style: TextStyle(color: Colors.red))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Fixed button at bottom
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () async{
                  //   // Navigator.of(context).pop();
                  //   quantities.forEach((index, qty) {
                  //     if (qty > 0) {
                  //       debugPrint(
                  //           'Item #$index Quantity: $qty | Total Amount: ₹${qty * allModelList[index]['prices']['originalPrice']}');
                  //     }
                  //   });
                  //   await addBulkItemsToCart(quantities);
                  //   Navigator.of(context).pop();
                  //   Navigator.pushNamed(context, '/cart');
                  // },
                  onPressed: () async {
                    if (allModelList.isEmpty) {
                      debugPrint('❌ allModelList is empty. Cannot proceed!');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('❌ No items to add!'),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(
                            label: 'Close',
                            textColor: Colors.redAccent,
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                      return;
                    }

                    bool hasItems = false;

                    quantities.forEach((index, qty) {
                      if (qty > 0) {
                        hasItems = true;
                        debugPrint(
                            'Item #$index Quantity: $qty | Total Amount: ₹${qty * allModelList[index]['prices']['originalPrice']}');
                      }
                    });

                    if (!hasItems) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('❗Please select at least one item!'),
                          backgroundColor: Colors.orange,
                          action: SnackBarAction(
                            label: 'Close',
                            textColor: Colors.redAccent,
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                      return;
                    }

                    await addBulkItemsToCart(quantities);
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/cart');
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulkBuyOptionsContent(BuildContext context) {
    Map<int, int> quantities = {};

    return SizedBox(
      height: MediaQuery.of(context).size.height *
          0.8, // Optional: Set a fixed height for the modal sheet
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 70), // Leave space for the button
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('Color',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('Price',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('Qty',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('Amount',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const Divider(),
                      alloptionList.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: alloptionList.length,
                              itemBuilder: (context, index) {
                                final item = alloptionList[index];
                                final itemNo = item['itemNo'];
                                final title = item['title']['en'] ?? 'No title';
                                final int originalPrice =
                                    item['prices']['price'];

                                quantities[index] = quantities[index] ?? 0;

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    int quantity = quantities[index]!;
                                    int amount = quantity * originalPrice;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  child: (item['image'] !=
                                                              null &&
                                                          item['image']
                                                              .isNotEmpty &&
                                                          item['image'][0]
                                                              is String)
                                                      ? Image.network(
                                                          item['image'][
                                                              0], // Ensure it's a valid URL string
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              const Icon(
                                                                  Icons.image),
                                                        )
                                                      : Image.network(
                                                          'https://img.myipadbox.com/upload/store/product_l/$itemNo.jpg',
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              const Icon(
                                                                  Icons.image),
                                                        ),

                                                  // child: (item['image'] !=
                                                  //             null &&
                                                  //         item['image']
                                                  //             .isNotEmpty)
                                                  //     ? item['image'][0]
                                                  //     : Image.network(
                                                  //         'https://img.myipadbox.com/upload/store/product_l/$itemNo.jpg',
                                                  //         fit: BoxFit.cover,
                                                  //         errorBuilder: (context,
                                                  //                 error,
                                                  //                 stackTrace) =>
                                                  //             const Icon(
                                                  //                 Icons.image),
                                                  //       ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 1,
                                                child: Text('₹$originalPrice',
                                                    style: const TextStyle(
                                                        color: Colors.red)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.remove),
                                                      iconSize: 12,
                                                      onPressed: () {
                                                        if (quantity > 0) {
                                                          setState(() {
                                                            quantities[index] =
                                                                quantity - 1;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    Text('$quantity'),
                                                    IconButton(
                                                      icon:
                                                          const Icon(Icons.add),
                                                      iconSize: 12,
                                                      onPressed: () {
                                                        setState(() {
                                                          quantities[index] =
                                                              quantity + 1;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    '₹${amount.round()}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          Text(title),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: Text('No items available',
                                  style: TextStyle(color: Colors.red)),
                            ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Fixed Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors
                  .white, // Optional: Adds a background color behind the button
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigator.of(context).pop();
                    quantities.forEach((index, qty) {
                      if (qty > 0) {
                        debugPrint(
                            'Item #$index Quantity: $qty | Total Amount: ₹${qty * alloptionList[index]['prices']['originalPrice']}');
                      }
                    });
                    await addBulkItemsToCart(quantities);
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/cart');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
