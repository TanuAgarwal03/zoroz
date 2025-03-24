import 'dart:convert';

import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Map<dynamic, dynamic>? cartData;
  Map<String, String>? deliveryAddress;
  List<dynamic>? cartItems;
  String? paymentMethod;
  String? address;
  String? city;
  String? country;
  String? zipcode;
  String? totalCartItems;
  String? totalCartPrice;
  String? name;
  String? contact;
  String? email;
  String? token;
  final Razorpay _razorpay = Razorpay();
  bool isLoading = false;
  String apiKey = '';

  @override
  void initState() {
    super.initState();
    fetchApiKey();
    getPaymentMethod();
    fetchLogindetails();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

  void getPaymentMethod() {
    var hiveBox = Hive.box('paymentBox');
    var hiveDeliveryBox = Hive.box('deliveryBox');
    var hiveCart = Hive.box('cartBox');
    setState(() {
      paymentMethod = hiveBox.get('paymentMethod');
      deliveryAddress = hiveDeliveryBox.get('deliveryAddress');
      cartData = hiveCart.get('cart');
      name = deliveryAddress!['name'];
      contact = deliveryAddress!['contact'].toString();
      email = deliveryAddress!['email'];
      address = deliveryAddress!['address'];
      city = deliveryAddress!['city'];
      country = deliveryAddress!['country'];
      zipcode = deliveryAddress!['zipCode'];
      cartItems = cartData!['items'];
      totalCartItems = cartData!['totalItems'].toString();
      totalCartPrice = cartData!['cartTotal'].toString();
    });
    print(paymentMethod);
    print(deliveryAddress);
    print(cartData);
    print(cartItems);
  }

  Future<void> _placeOrder() async {
    setState(() => isLoading = true);
    final url = Uri.parse('https://backend.vansedemo.xyz/api/order/add');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "user_info": {
            "name": name,
            "contact": contact,
            "email": email,
            "address": address,
            "country": country,
            "city": city,
            "zipCode": zipcode
          },
          "paymentMethod": paymentMethod,
          "status": "Pending",
          "cart": cartItems,
          "subTotal": totalCartPrice,
          "shippingCost": 0,
          "discount": 0,
          "total": totalCartPrice
        }),
      );

      final data = jsonDecode(response.body);
      print('placed order - $data');
      print(response.statusCode);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Order placed successfully',
              style: TextStyle(color: Colors.white),
            ),
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
        Navigator.pushNamed(context, '/my_orders');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Failed to place Order',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
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
      }
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('An error occurred! Please try again.'),
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
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchApiKey() async {
    final url = Uri.parse(
        'https://backend.vansedemo.xyz/api/setting/store-setting/all');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        setState(() {
          apiKey = data['razorpay_id'] ?? 'rzp_test_Ux3634ZRBdjcQO';
        });
        print('$apiKey');
      } else {
        debugPrint("Failed to load payment methods");
      }
    } catch (e) {
      debugPrint("Error fetching payment methods: $e");
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
                title: const Text('Checkout'),
                centerTitle: true,
                titleSpacing: 5,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Theme.of(context).cardColor,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Theme.of(context).dividerColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).dividerColor)),
                                  alignment: Alignment.center,
                                  child: SvgPicture.string(
                                    IKSvg.mapmarker,
                                    width: 20,
                                    height: 20,
                                    // ignore: deprecated_member_use
                                    color: IKColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Delivery address',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(height: 4),
                                    Text('$address,$city,$country,$zipcode',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Theme.of(context).dividerColor))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).dividerColor)),
                                  alignment: Alignment.center,
                                  child: SvgPicture.string(
                                    IKSvg.card,
                                    width: 20,
                                    height: 20,
                                    // ignore: deprecated_member_use
                                    color: IKColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Payment',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(height: 4),
                                    (paymentMethod == 'Cash')
                                        ? Text('Cash on Delivery',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium)
                                        : Text('RazorPay',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(15),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.stretch,
                          //     children: [
                          //       Text('Additional Notes:',
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .titleMedium
                          //               ?.merge(const TextStyle(
                          //                   fontWeight: FontWeight.w400,
                          //                   fontSize: 15))),
                          //       TextFormField(
                          //         maxLines: 2,
                          //         keyboardType: TextInputType.multiline,
                          //         decoration: InputDecoration(
                          //           border: const UnderlineInputBorder(),
                          //           labelText: 'Write Here',
                          //           labelStyle: Theme.of(context)
                          //               .textTheme
                          //               .bodyMedium
                          //               ?.merge(const TextStyle(fontSize: 15)),
                          //           floatingLabelStyle: Theme.of(context)
                          //               .textTheme
                          //               .titleMedium
                          //               ?.merge(const TextStyle(
                          //                   color: IKColors.primary)),
                          //           enabledBorder: UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color: Theme.of(context)
                          //                       .dividerColor)),
                          //           focusedBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2, color: IKColors.primary)),
                          //           contentPadding:
                          //               const EdgeInsets.symmetric(vertical: 5),
                          //         ),
                          //         cursorColor: IKColors.primary,
                          //         style: TextStyle(
                          //             color: Theme.of(context)
                          //                 .textTheme
                          //                 .titleMedium
                          //                 ?.color),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).cardColor,
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Theme.of(context).dividerColor))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Text('Price Details',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price ($totalCartItems items)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                fontWeight: FontWeight.w400))),
                                    Text('₹ $totalCartPrice',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                fontWeight: FontWeight.w400)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Discount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                fontWeight: FontWeight.w400))),
                                    Text('₹ 0.0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                fontWeight: FontWeight.w400)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Shipping cost',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                fontWeight: FontWeight.w400))),
                                    Text('Free Delivery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.success,
                                                fontWeight: FontWeight.w400)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 1,
                                        color:
                                            Theme.of(context).dividerColor))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Amount',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                Text('₹ $totalCartPrice',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.merge(const TextStyle(
                                            color: IKColors.success)))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: IKColors.secondary),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (paymentMethod == 'Cash') {
                            print('Placing COD order');
                            await _placeOrder();
                          } else {
                            var options = {
                              'key': apiKey,
                              'amount':
                                  (double.parse(totalCartPrice ?? '0') * 100)
                                      .toString(),
                              'currency': 'INR',
                              'name': 'Zoroz',
                              'description': 'Paying $totalCartPrice to Zoroz',
                              'prefill': {
                                'contact': '9311796739',
                                'email': 'contact@zoroz.in',
                              },
                            };

                            try {
                              _razorpay.open(options);
                            } catch (e) {
                              debugPrint('Error opening Razorpay: $e');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.secondary,
                          side: const BorderSide(color: IKColors.secondary),
                          foregroundColor: IKColors.title,
                        ),
                        child: const Text(
                          'Submit Order',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
 
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _placeOrder();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pushNamed(context, '/checkout');

    print('Payment Failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
