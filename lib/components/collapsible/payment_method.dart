import 'dart:convert';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String _active = "";

  bool codStatus = false;
  bool razorpayStatus = false;
  bool stripeStatus = false;
  final String hiveBoxName = 'paymentBox';

  @override
  void initState() {
    super.initState();
    fetchPaymentMethods();
  }

  Future<void> fetchPaymentMethods() async {
    final url = Uri.parse(
        'https://backend.vansedemo.xyz/api/setting/store-setting/all');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        setState(() {
          codStatus = data['cod_status'] ?? false;
          razorpayStatus = data['razorpay_status'] ?? false;
          stripeStatus = data['stripe_status'] ?? false;
        });
        print('$codStatus , $razorpayStatus , $stripeStatus');
      } else {
        debugPrint("Failed to load payment methods");
      }
    } catch (e) {
      debugPrint("Error fetching payment methods: $e");
    }
  }

  void _toggleHeight(String val) async {
    setState(() {
      _active = val;
    });

    String selectedMethod = '';

    if (val == "Cash") {
      selectedMethod = "Cash";
    } else if (val == "RazorPay") {
      selectedMethod = "Card";
    } else if (val == "Stripe") {
      selectedMethod = "Stripe";
    }
    var box = await Hive.openBox(hiveBoxName);
    await box.put('paymentMethod', selectedMethod);
    print('Payment Method saved: $selectedMethod');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (codStatus == true)
          _buildPaymentOption(
            title: 'Cash on Delivery (Cash/UPI)',
            icon: IKSvg.dollor,
            value: 'Cash',
          ),
        if (razorpayStatus == true)
          _buildPaymentOption(
            title: 'RazorPay',
            icon: IKSvg.money2,
            value: 'RazorPay',
          ),
        if (stripeStatus == true)
          _buildPaymentOption(
            title: 'Stripe Payment',
            icon: IKSvg.money2,
            value: 'Stripe',
          ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String icon,
    required String value,
  }) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              _toggleHeight(value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              child: Row(
                children: [
                  SvgPicture.string(
                    icon,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(title,
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).dividerColor,
                    ),
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _active == value
                            ? IKColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      height: 11,
                      width: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
