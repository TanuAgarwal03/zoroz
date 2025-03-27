import 'dart:convert';
import 'dart:io';
import 'package:clickcart/components/product/product_card.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String _activeFilter = 'all';
  List _allOrders = [];
  String token = '';
  bool _isLoading = true;
  List _displayOrders = [];
  final List<Map<String, String>> orderItems = [];

  @override
  void initState() {
    super.initState();
    fetchLogindetails();
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

      setState(() {
        token = loginData['token'];
      });
    }
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final url =
        Uri.parse('https://backend.vansedemo.xyz/api/order?limit=10&page=1');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final orders = data['orders'];

        List orderList = [];

        for (var order in orders) {
          print("Order ID: ${order['_id']}");

          final cartItems = order['cart'];
          print(cartItems);
          for (var item in cartItems) {
            orderList.add({
              'orderId': order['_id'],
              'orderDate': order['createdAt'],
              'orderItemquantity': order['quantity'],
              'paymentMethod': order['paymentMethod'],
              'totalCost': order['total'],
              'subTotal': order['subTotal'],
              'shippingCost': order['shippingCost'],
              'discount': order['discount'],
              'orderAddress': order['user_info'],
              'id': item['_id'],
              'category': item['category'],
              'title': item['title']['en'],
              'image':
                  'https://img.myipadbox.com/upload/store/product_l/${item['itemNo']}.jpg',
              'price': item['prices']['price'],
              'old-price': item['prices']['originalPrice'],
              'offer': item['prices']['discount'],
              'returnday': '14',
              'count': item['quantity'],
              'slug': item['slug'],
              'reviews': '0',
              'order-status': order['status'].toLowerCase(),
              'order-rated': 'no',
              'itemNo': item['itemNo'] ?? '',
            });
          }
        }
        setState(() {
          _allOrders = orderList;
          _displayOrders = List.from(orderList);
          _isLoading = false;
        });
        _orderFilter(_activeFilter);
      } else {
        print('Failed to load orders: ${response.statusCode}');
        setState(() {
          _isLoading = false; // stop loading even on error
        });
      }
    } catch (error) {
      print('Error fetching orders: $error');
      setState(() {
        _isLoading = false; // stop loading even on error
      });
    }
  }

  void _orderFilter(String filter) {
    List sortedOrders = List.from(_allOrders);

    if (filter == 'newest') {
      sortedOrders.sort((a, b) => DateTime.parse(b['orderDate'])
          .compareTo(DateTime.parse(a['orderDate'])));
    } else if (filter == 'oldest') {
      sortedOrders.sort((a, b) => DateTime.parse(a['orderDate'])
          .compareTo(DateTime.parse(b['orderDate'])));
    }

    setState(() {
      _activeFilter = filter;
      _displayOrders = sortedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<dynamic>> groupedOrders = {};

    for (var item in _displayOrders) {
      String orderId = item['orderId'];

      if (groupedOrders.containsKey(orderId)) {
        groupedOrders[orderId]!.add(item);
      } else {
        groupedOrders[orderId] = [item];
      }
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: IKSizes.container),
              child: AppBar(
                title: const Text('My Orders'),
                titleSpacing: 5,
                centerTitle: true,
              ),
            ),
          )),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: IKSizes.container),
          child: _isLoading
              ? const Center(
                  child: SizedBox(
                    width: 25,
                    child: LoadingIndicator(
                      indicatorType: Indicator.lineScalePulseOut,
                    ),
                  ),
                )
              : groupedOrders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No orders yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: IKColors.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 52),
                        child: Column(
                          children: groupedOrders.entries.map((entry) {
                            String orderId = entry.key;
                            List<dynamic> items = entry.value;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: Card(
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                child: InkWell(
                                  onTap: () => _showOrderDetailsBottomSheet(
                                      context, orderId, items),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            'Order ID: $orderId',
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(items[0]['orderDate']))}',
                                                style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _showOrderDetailsBottomSheet(
                                                      context, orderId, items);
                                                },
                                                child: const Text(
                                                  'View Order',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                      decorationColor:
                                                          Colors.red),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(color: Colors.grey[200]),
                                        Column(
                                          children: items.map((item) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Product Image
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      item['image'] ??
                                                          'https://img.myipadbox.com/upload/store/product_l/${item['itemNo']}.jpg',
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return const SizedBox(
                                                          width: 80,
                                                          height: 80,
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2)),
                                                        );
                                                      },
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Image.asset(
                                                          'assets/images/placeholder.jpg',
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),

                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item['title'] ??
                                                                '--',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),

                                                          const SizedBox(
                                                              height: 8),

                                                          // Price and Qty Row
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                flex: 1,
                                                                child: Text(
                                                                  '₹${item['price'] ?? '--'}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              Flexible(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Qty: ${item['count'] ?? '--'}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // All Orders Button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _orderFilter('all'),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      'All Orders',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.merge(
                                            TextStyle(
                                              fontSize: 15,
                                              color: _activeFilter == 'all'
                                                  ? IKColors.primary
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.color,
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                              ),

                              // Sort by Date Dropdown
                              Expanded(
                                child: PopupMenuButton<String>(
                                  color: Colors.white,
                                  onSelected: (value) {
                                    _orderFilter(value);
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'newest',
                                      child: Row(
                                        children: [
                                          if (_activeFilter == 'newest')
                                            const Icon(Icons.check,
                                                size: 16,
                                                color: IKColors.primary),
                                          if (_activeFilter != 'newest')
                                            const SizedBox(width: 16),
                                          const SizedBox(width: 8),
                                          const Text('Newest to Oldest'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'oldest',
                                      child: Row(
                                        children: [
                                          if (_activeFilter == 'oldest')
                                            const Icon(Icons.check,
                                                size: 16,
                                                color: IKColors.primary),
                                          if (_activeFilter != 'oldest')
                                            const SizedBox(width: 16),
                                          const SizedBox(width: 8),
                                          const Text('Oldest to Newest'),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.sort,
                                            size: 20,
                                            color: Colors.grey), // Sort icon
                                        const SizedBox(width: 6),
                                        Text(
                                          'Sort by Date',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.merge(
                                                TextStyle(
                                                  fontSize: 15,
                                                  color: (_activeFilter ==
                                                              'newest' ||
                                                          _activeFilter ==
                                                              'oldest')
                                                      ? IKColors.primary
                                                      : Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.color,
                                                ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
        ),
      ),
    );
  }

  void _showOrderDetailsBottomSheet(
      BuildContext context, String orderId, List<dynamic> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
      ),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  color: Theme.of(context).cardColor,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('Order Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  )),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: $orderId',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Order Date: ${formatDate(items.first['orderDate'])}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 1),
              ...items.map((item) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/product_detail',
                            arguments: ScreenArguments(
                                item['title'].toString(),
                                item['image'].toString(),
                                item['price'].toString(),
                                item['old-price'].toString(),
                                item['offer'].toString(),
                                item['itemNo'].toString(),
                                item['slug'].toString()),
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                            color: Theme.of(context).cardColor,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['image'] ??
                                          'https://img.myipadbox.com/upload/store/product_l/${item['itemNo']}.jpg',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2)),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/placeholder.jpg',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Text('₹${item['price']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Qty: ${item['count']}'),
                                            const Text(
                                              'View Product',
                                              style: TextStyle(
                                                  color: IKColors.primary),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))));
              }).toList(),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: IKColors.primary,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Delivery Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text('${items.first['orderAddress']['name']}'),
                    Text(
                        '${items.first['orderAddress']['address']}, ${items.first['orderAddress']['city']}, ${items.first['orderAddress']['country']} - ${items.first['orderAddress']['zipCode']}'),
                    Text('${items.first['orderAddress']['contact']}'),
                    Text('${items.first['orderAddress']['email']}'),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('₹${items.first['subTotal']}      '),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shipping Cost',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('₹${items.first['shippingCost']}      '),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Discount Applied',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text('₹${items.first['discount']}      '),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.wallet),
                            Text(
                              (items.first['paymentMethod'] == 'Cash')
                                  ? 'Cash on Delivery'
                                  : 'RazorPay',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Text('₹${items.first['totalCost'].toString()}      '),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          generateInvoice(orderId, items, context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invoice downloaded')),
                          );
                        },
                        icon: const Icon(Icons.download, color: Colors.white),
                        label: const Text('Invoice'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.infinity, 50),
                          // backgroundColor: Colors.green // Set fixed height
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Spacing between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(
                              double.infinity, 50), // Set fixed height
                        ),
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      //   );
      // },
    );
  }

  String formatDate(String isoDate) {
    try {
      DateTime parsedDate = DateTime.parse(isoDate);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return isoDate;
    }
  }

  Future<void> generateInvoice(
      String orderId, List<dynamic> items, BuildContext context) async {
    final pdf = pw.Document();
    final order = items.first;

    final ByteData bytes =
        await rootBundle.load('assets/images/zoroz_logo.jpg'); // Load logo
    final Uint8List logo = bytes.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Invoice",
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Container(
                    height: 50,
                    width: 50,
                    child: pw.Image(pw.MemoryImage(logo)), // Display logo
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text("Order ID: $orderId",
                  style: const pw.TextStyle(fontSize: 16)),
              pw.Text("Order Date: ${order['orderDate']}"),
              pw.Text(
                  "Order Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(order['orderDate']))}"),
              pw.SizedBox(height: 10),

              pw.Text("Customer Details:",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text("${order['orderAddress']['name']}"),
              pw.Text(
                  "${order['orderAddress']['address']}, ${order['orderAddress']['city']}, ${order['orderAddress']['country']} - ${order['orderAddress']['zipCode']}"),
              pw.Text("Phone: ${order['orderAddress']['contact']}"),
              pw.Text("Email: ${order['orderAddress']['email']}"),
              pw.SizedBox(height: 10),

              pw.Text("Order Summary:",
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),

              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text("Item",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text("Qty",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text("Price",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                    ],
                  ),

                  ...items.map((item) => pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(item['title'],
                                style: const pw.TextStyle(fontSize: 12))),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(item['count'].toString(),
                                style: const pw.TextStyle(fontSize: 12),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text("Rs.${item['price']}",
                                style: const pw.TextStyle(fontSize: 12),
                                textAlign: pw.TextAlign.right)),
                      ])),
                ],
              ),

              pw.SizedBox(height: 10),
              pw.Divider(),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Subtotal:", style: const pw.TextStyle(fontSize: 14)),
                  pw.Text("Rs.${order['subTotal']}",
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Shipping Cost:",
                      style: const pw.TextStyle(fontSize: 14)),
                  pw.Text("Rs.${order['shippingCost']}",
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Discount:", style: const pw.TextStyle(fontSize: 14)),
                  pw.Text("- Rs.${order['discount']}",
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total Amount:",
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Rs.${order['totalCost']}",
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );
    final output = await getExternalStorageDirectory();
    print(output!.path);
    final file = File("${output.path}/Invoice_$orderId.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }
}
