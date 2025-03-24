import 'dart:convert';

import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class AddressItem {
  String title;

  AddressItem({required this.title});
}

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({super.key});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _pinController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final TextEditingController _countryController =
      TextEditingController(text: "India");

  final _formKey = GlobalKey<FormState>();
  String? userId;
  final String hiveBoxName = 'deliveryBox';

  @override
  void initState() {
    super.initState();
    fetchLogindetails();
  }

  void fetchLogindetails() async {
    var box = await Hive.openBox('userBox');
    final loginData = box.get('loginData');

    if (loginData != null) {
      print('Phone: ${loginData['phone']}');
      print('Token (if available): ${loginData['token']}');
      print('Name : ${loginData['name']}');
      print('Email : ${loginData['email']}');
      print('Id : ${loginData['_id']}');
      setState(() {
        userId = loginData['_id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Delivery Address'),
        titleSpacing: 5,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: IKSizes.container),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: IKColors.primary,
                                borderRadius: BorderRadius.circular(9)),
                            child: const Text('1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text('Cart',
                              style: Theme.of(context).textTheme.titleMedium),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2, color: IKColors.primary))),
                          )),
                          Container(
                            height: 18,
                            width: 18,
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: IKColors.primary,
                                borderRadius: BorderRadius.circular(9)),
                            child: const Text('2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text('Address',
                              style: Theme.of(context).textTheme.titleMedium),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color:
                                            Theme.of(context).dividerColor))),
                          )),
                          Container(
                            height: 18,
                            width: 18,
                            padding: const EdgeInsets.only(bottom: 0),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.circular(9)),
                            child: Text('3',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                          Text('Payment',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.merge(const TextStyle(
                                      fontWeight: FontWeight.w500))),
                        ],
                      )),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      Container(
                        color: Theme.of(context).cardColor,
                        margin: const EdgeInsets.only(top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Theme.of(context)
                                                .dividerColor))),
                                child: Text('Contact Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium)),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Full Name',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      controller: _phoneController,
                                      maxLength: 10,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Phone number is required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Mobile No.',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: TextFormField(
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter valid email';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Email address',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Theme.of(context).cardColor,
                        margin: const EdgeInsets.only(top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Theme.of(context)
                                                .dividerColor))),
                                child: Text('Address',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium)),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      controller: _pinController,
                                      maxLength: 6,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Pin code is required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Pin Code',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      keyboardType: TextInputType.number,
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      controller: _addressController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your address';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Address',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      controller: _cityController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your city';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'City/District',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _countryController,
                                      validator: null,
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Country',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.merge(
                                                const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                color: IKColors.primary)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Theme.of(context)
                                                    .dividerColor)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: IKColors.primary)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.color),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
                        // Navigator.pushNamed(context, '/payment');

                        // Navigator.pushNamed(context, '/delivery_address');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.secondary,
                          side: const BorderSide(color: IKColors.secondary),
                          foregroundColor: IKColors.title),
                      child: const Text(
                        'Save Address',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      saveDeliverAddress();
    }
  }

  Future<void> saveDeliverAddress() async {
    final url = Uri.parse(
        'https://backend.vansedemo.xyz/api/customer/shipping/address/$userId');
    final body = {
      "name": _nameController.text,
      "contact": _phoneController.text,
      "email": _emailController.text,
      "address": _addressController.text,
      "country": _countryController.text,
      "city": _cityController.text,
      "zipCode": _pinController.text
    };

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] ==
            "Shipping address added or updated successfully.") {
          var box = await Hive.openBox(hiveBoxName);
          await box.put('deliveryAddress', body);
          print('Address saved saved $userId: $body');

          Navigator.pushNamed(context, '/payment');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message']),action: SnackBarAction(
      label: 'Close',
      textColor: Colors.redAccent,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    duration: const Duration(seconds: 5), ),
          );
        }
      } else {
        print("Failed: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body),action: SnackBarAction(
      label: 'Close',
      textColor: Colors.redAccent,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    duration: const Duration(seconds: 5), ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Something went wrong!'),action: SnackBarAction(
      label: 'Close',
      textColor: Colors.redAccent,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    duration: const Duration(seconds: 5), ),
      );
    }
  }
}
