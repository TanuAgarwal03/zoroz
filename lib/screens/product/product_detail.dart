import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:clickcart/components/home/service_list.dart';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_share/social_share.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  dynamic _isWishlist = false;
  List<Map<String, dynamic>> priceList = [];
  List<Map<String, dynamic>> optionListItems = [];
  List<Map<String, dynamic>> colorListItem = [];
  // List<Map<String, dynamic>> alloptionListDataItems = [];
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProductDetail();
    });
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

            productDescription = productDetail!['description']['en'];
            sku = productDetail!['sku'];
            price = productDetail!['prices']['price'];
            unitHeight = productDetail!['unitHeight'];
            unitLength = productDetail!['unitLength'];
            unitWidth = productDetail!['unitWidth'];
            unitWeight = productDetail!['unitWeight'];
            packHeight = productDetail!['packHeight'];
            packLength = productDetail!['packLength'];
            packWidth = productDetail!['packWidth'];
            packWeight = productDetail!['packWeight'];
            packQty = productDetail!['packQty'];
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
          return data['productDetail'];
        } else {
          print('API Error: ${data['message']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}, ${response.body}');
        // return null;
      }
    } catch (e) {
      print('Exception: $e');
      // return null;
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
                title: const Text('Product Details'),
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
                            color: const Color.fromARGB(255, 255, 238, 238),
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
                              top: 15,
                              left: 15,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                color: IKColors.success,
                                child: Text(args.offer,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              )),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isWishlist = !_isWishlist;
                                });
                              },
                              iconSize: 20,
                              icon: SvgPicture.string(
                                IKSvg.heart,
                                width: 20,
                                height: 20,
                                // ignore: deprecated_member_use
                                color: _isWishlist
                                    ? IKColors.danger
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 50,
                            child: IconButton(
                              onPressed: () {
                                SocialShare.shareOptions('content here...');
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
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text('In Stock',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.merge(const TextStyle(
                                      color: IKColors.success, fontSize: 15))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('₹${_getPrice().toStringAsFixed(0)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.merge(const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: IKColors.success))),
                                  const SizedBox(width: 6),
                                  (args.offer == '0')
                                      ? const Text('')
                                      : Text('\$${args.oldPrice}',
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
                                  (args.offer == '0')
                                      ? const Text('')
                                      : Text(args.offer,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.merge(const TextStyle(
                                                  color: IKColors.danger))),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              _buildQuantitySelector()
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'SKU : $sku',
                            style: const TextStyle(color: Colors.black),
                          ),
                          if (optionListItems.isNotEmpty)
                            Row(
                              children: [
                                const Text('Options : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                      isLoading = true; // Start loading
                                    });
                                      await _fetchProductDetail();
                                      if (context.mounted) {
                                        _showBulkBuyPopupforOptions(context);
                                      }
                                      setState(() {
                                      isLoading = false; // Stop loading
                                    });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 24,
                                        width: 75,
                                        child: Center(
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: LoadingIndicator(
                                                indicatorType:
                                                    Indicator.lineScalePulseOut,
                                                colors: [Colors.white],
                                              ),
                                            )
                                          : const Text(
                                              'Bulk Buy',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    )))
                              ],
                            ),
                          _buildOptionList(),
                          if (colorListItem.isNotEmpty)
                            Row(
                              children: [
                                const Text('Same model in different Color : ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true; // Start loading
                                    });

                                    await _fetchProductDetail();

                                    if (context.mounted) {
                                      _showBulkBuyPopupforModel(context);
                                    }

                                    setState(() {
                                      isLoading = false; // Stop loading
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 24,
                                    width: 75,
                                    child: Center(
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: LoadingIndicator(
                                                indicatorType:
                                                    Indicator.lineScalePulseOut,
                                                colors: [Colors.white],
                                              ),
                                            )
                                          : const Text(
                                              'Bulk Buy',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          _buildColorList(),
                          _buildHorizontalPriceTable(),
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
                              'One Package Weight', '$unitWeight kgs'),
                          _buildSpecification('One Package Size',
                              '${unitLength}cm*${unitWidth}cm*${unitHeight}cm'),
                          _buildSpecification(
                              'Qty per Carton', packQty?.toString() ?? 'N/A'),
                          _buildSpecification(
                              'Carton Weight', '$packWeight kgs'),
                          _buildSpecification('Carton Size',
                              '${packLength.toString()}cm*${packWidth.toString()}cm*${packHeight.toString()}cm'),
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
                        Navigator.pushNamed(context, '/cart');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: IKColors.secondary,
                        side: const BorderSide(color: IKColors.secondary),
                      ),
                      child: const Text('Buy Now',
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
              )
            : const SizedBox(),
      );
    }

    return SizedBox(
      height: 90,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                width: 120,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
          final bool status = optionItem.containsKey('isCustomProduct')
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
                    const Icon(Icons.image), // Handles broken image URLs
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
        print("Success: $responseData");

        final productItem = responseData['productItem'];
        final slug = productItem['slug'];
        final returnedItemNo = productItem['itemNo'];
        final title = productItem['title']['en'];
        final images = productItem['image'];
        final firstImage = images.isNotEmpty ? images[0] : '';
        final price = productItem['prices']['originalPrice'].toString();
        final oldPrice = productItem['prices']['price'].toString();
        final offer = productItem['prices']['discount'].toString();

        print("Slug: $slug");
        print("ItemNo: $returnedItemNo");

        // Navigate with arguments
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

  Widget _buildHorizontalPriceTable() {
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
              : const Text("No price list available"));
    }

    final selectedIndex = getSelectedIndexFromQuantity(_quantity);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: priceList.map((priceItem) {
                return Container(
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: Text(
                      '${priceItem['key']}+ units',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }).toList(),
            ),
            Row(
              children: priceList.asMap().entries.map((entry) {
                final index = entry.key;
                final priceItem = entry.value;
                return Container(
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? const Color.fromARGB(255, 240, 216, 180)
                        : Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Center(
                    child: Text(
                      'Rs.${(double.parse(priceItem['value']) * 85).toStringAsFixed(0)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
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

  void _showBulkBuyPopupforOptions(BuildContext context) {
    Map<int, int> quantities = {};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final double sheetHeight = MediaQuery.of(context).size.height * 0.7;

        return SafeArea(
          child: SizedBox(
            height: sheetHeight, // Fixed 70% height
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Options - Bulk Buy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
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
                                final title = item['title']['en'];
                                final int originalPrice =
                                    item['prices']['originalPrice'];

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
                                                  'https://img.myipadbox.com/upload/store/product_l/${itemNo}.jpg',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(Icons.image),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '₹$originalPrice',
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
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
                                                    icon: const Icon(Icons.add),
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
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(title),
                                        const Divider()
                                      ],
                                    ),
                                  );
                                });
                              },
                            )
                          : const Center(
                              child: Text(
                                'No items available',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            quantities.forEach((index, qty) {
                              if (qty > 0) {
                                debugPrint(
                                    'Item #$index Quantity: $qty | Total Amount: ₹${qty * alloptionList[index]['prices']['originalPrice']}');
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBulkBuyPopupforModel(BuildContext context) {
    Map<int, int> quantities = {};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final double sheetHeight = MediaQuery.of(context).size.height * 0.7;

        return SafeArea(
          child: SizedBox(
            height: sheetHeight, // Fixed 70% height
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Same model in different Color - Bulk Buy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
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
                                    item['prices']['originalPrice'];

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
                                                  'https://img.myipadbox.com/upload/store/product_l/${itemNo}.jpg',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(Icons.image),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '₹$originalPrice',
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
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
                                                    icon: const Icon(Icons.add),
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
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(title),
                                        const Divider()
                                      ],
                                    ),
                                  );
                                });
                              },
                            )
                          : const Center(
                              child: Text(
                                'No items available',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            quantities.forEach((index, qty) {
                              if (qty > 0) {
                                debugPrint(
                                    'Item #$index Quantity: $qty | Total Amount: ₹${qty * alloptionList[index]['prices']['originalPrice']}');
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
