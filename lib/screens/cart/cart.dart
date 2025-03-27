import 'package:clickcart/components/product/product_cart.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int cartTotal = 0;
  int totalItems = 0;
  // bool isCustomProduct = false;
  double grandTotal = 0.0;

  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  void fetchCartData() {
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

    double updatedCartTotal = items.fold(0.0, (total, currentItem) {
      int quantity = int.tryParse(currentItem['quantity'].toString()) ?? 1;
      List<dynamic> priceList = currentItem['priceList'] ?? [];

      bool isCustomProduct = currentItem.containsKey('isCustomProduct')
          ? currentItem['isCustomProduct'] == true
          : false;

      int calculatedPrice = calculatePriceFromList(quantity, priceList,
          isCustomProduct: isCustomProduct);

      return total + (calculatedPrice * quantity);
    });

    int totalQuantity = items.fold(0, (sum, currentItem) {
      int quantityValue = int.tryParse(currentItem['quantity'].toString()) ?? 0;
      return sum + quantityValue;
    });

    /// ✅ Update the cartBox data if needed (optional)
    existingCart['cartTotal'] = updatedCartTotal;
    existingCart['totalItems'] = totalQuantity;
    cartBox.put('cart', existingCart); // Optional, keeps storage in sync

    /// ✅ Update UI
    setState(() {
      cartItems = items;
      cartTotal = updatedCartTotal.toInt();
      totalItems = totalQuantity;
     
    });
    print('Cart display : $cartItems');
  }

  void updateQuantity(String itemNo, {required bool increase}) async {
    final cartBox = Hive.box('cartBox');
    var existingCartRaw = cartBox.get('cart');

    if (existingCartRaw != null) {
      Map<String, dynamic> existingCart =
          Map<String, dynamic>.from(existingCartRaw);

      List<dynamic> items = existingCart['items'];

      int index = items.indexWhere((element) => element['itemNo'] == itemNo);
      if (index != -1) {
        var item = Map<String, dynamic>.from(items[index]);
        int currentQuantity = item['quantity'] ?? 1;

        if (increase) {
          currentQuantity += 1;
        } else {
          currentQuantity -= 1;
          if (currentQuantity < 1) {
            currentQuantity = 1;
          }
        }

        item['quantity'] = currentQuantity;
        items[index] = item;
// Updated Cart After Adding: {items: [{prices: {originalPrice: 15, price: 5, discount: 10}, _id: 6 7dc4e6176c08d1099a030e2, productId: 67dc4e6176c08d1099a030e1,
        // ✅ Updated cart total calculation using priceList
        double updatedCartTotal = items.fold(0.0, (total, currentItem) {
          int quantity = int.tryParse(currentItem['quantity'].toString()) ?? 1;
          List<dynamic> priceList = currentItem['priceList'] ?? [];

          bool isCustomProduct = currentItem.containsKey('isCustomProduct')
              ? currentItem['isCustomProduct'] == true
              : false;

          int calculatedPrice = calculatePriceFromList(quantity, priceList,
              isCustomProduct: isCustomProduct);

          return total + (calculatedPrice * quantity);
        });

        int totalQuantity = items.fold(0, (sum, currentItem) {
          int quantityValue =
              int.tryParse(currentItem['quantity'].toString()) ?? 0;
          return sum + quantityValue;
        });

        existingCart['items'] = items;
        existingCart['cartTotal'] = updatedCartTotal;
        existingCart['totalItems'] = totalQuantity;

        await cartBox.put('cart', existingCart);
        setState(() {
          cartItems = items.map((e) => Map<String, dynamic>.from(e)).toList();
          cartTotal = updatedCartTotal.toInt();
          totalItems = totalQuantity;
        });
      }
    }
  }

  // void updateQuantity(String itemNo, {required bool increase}) async {
  //   final cartBox = Hive.box('cartBox');
  //   var existingCartRaw = cartBox.get('cart');
  //   if (existingCartRaw != null) {
  //     Map<String, dynamic> existingCart =
  //         Map<String, dynamic>.from(existingCartRaw);
  //     List<dynamic> items = existingCart['items'];
  //     int index = items.indexWhere((element) => element['itemNo'] == itemNo);
  //     if (index != -1) {
  //       var item = Map<String, dynamic>.from(items[index]);
  //       int currentQuantity = item['quantity'] ?? 1;
  //      if (increase) {
  //         currentQuantity += 1;
  //       } else {
  //         currentQuantity -= 1;
  //         if (currentQuantity < 1) {
  //           currentQuantity = 1;
  //         }
  //       }
  //       item['quantity'] = currentQuantity;
  //       items[index] = item;
  //       double updatedCartTotal = items.fold(0.0, (total, currentItem) {
  //         var price = currentItem['prices']['originalPrice'];
  //         var quantity = currentItem['quantity'];
  //         double priceValue = double.tryParse(price.toString()) ?? 0.0;
  //         int quantityValue = int.tryParse(quantity.toString()) ?? 0;
  //         return total + (priceValue * quantityValue);
  //       });
  //       int totalQuantity = items.fold(0, (sum, currentItem) {
  //         int quantityValue =
  //             int.tryParse(currentItem['quantity'].toString()) ?? 0;
  //         return sum + quantityValue;
  //       });
  //       existingCart['items'] = items;
  //       existingCart['cartTotal'] = updatedCartTotal;
  //       existingCart['totalItems'] = totalQuantity;
  //       await cartBox.put('cart', existingCart);
  //       setState(() {
  //         cartItems = items.map((e) => Map<String, dynamic>.from(e)).toList();
  //         cartTotal = updatedCartTotal.toInt();
  //         totalItems = totalQuantity;
  //       });
  //     }
  //   }
  // }

  void showClearCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text('Are you sure you want to clear all cart items?', style: TextStyle(fontSize: 14),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0)
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                clearCart();
                Navigator.of(context).pop(); // Close the dialog after clearing
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void clearCart() async {
    final cartBox = Hive.box('cartBox');
    await cartBox.put('cart', {
      "items": [],
      "isEmpty": true,
      "cartTotal": 0.0,
      "totalItems": 0,
      "totalUniqueItems": 0
    });

    setState(() {
      cartItems = [];
      cartTotal = 0;
      totalItems = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cart has been cleared!', style: TextStyle(color: Colors.white),),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
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
              title: const Text('Shopping Cart'),
              titleSpacing: 5,
              actions: [
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconButton(
                        onPressed: () {
                          showClearCartDialog();
                        },
                        icon: const Icon(Icons.delete_forever,
                            color: Colors.white, size: 30))
                    )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: const BoxConstraints(maxWidth: IKSizes.container),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStepIndicator(context),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    cartItems.isEmpty
                        ? const Center(child: Text('Your cart is empty.'))
                        : _buildCartItemsList(),
                    _buildBottomPriceDetails(context),
                  ],
                ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: IKColors.card,
                            side: const BorderSide(color: IKColors.card),
                            foregroundColor: IKColors.title,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Total : ₹$cartTotal',
                                style: const TextStyle(color: IKColors.primary),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/add_delivery_address');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.secondary,
                          side: const BorderSide(color: IKColors.secondary),
                          foregroundColor: IKColors.title,
                        ),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        children: [
          _buildStepCircle(context, '1', isActive: true),
          Text('Cart', style: Theme.of(context).textTheme.titleMedium),
          _buildDivider(context),
          _buildStepCircle(context, '2'),
          Text('Address',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.merge(const TextStyle(fontWeight: FontWeight.w500))),
          _buildDivider(context),
          _buildStepCircle(context, '3'),
          Text('Payment',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.merge(const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildStepCircle(BuildContext context, String number,
      {bool isActive = false}) {
    return Container(
      height: 18,
      width: 18,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: isActive ? IKColors.primary : Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white : Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartItemsList() {
    return SingleChildScrollView(
      child: Column(
        children: cartItems.map((item) {
          String itemNo = item['itemNo'] ?? 'default';
          int quantity = int.tryParse(item['quantity'].toString()) ?? 1;
          // print('cartitems : ${ item['title']['en']}');
          bool isCustomProduct = item.containsKey('isCustomProduct')
              ? item['isCustomProduct'] == true
              : false;

          List<dynamic> priceList = item['priceList'] ?? [];

          int calculatedPrice = calculatePriceFromList(quantity, priceList,
              isCustomProduct: isCustomProduct);

          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: ProductCart(
              slug: item['slug'] ?? 'polar-m600-charging-cable-black',
              itemNo: itemNo,
              title: item['title']['en'] ?? 'No Title',
              price: calculatedPrice.toString(), // Using calculated price here
              oldPrice: item['prices']['originalPrice'].toString(),
              image: (item['image'] != null && item['image'].isNotEmpty)
                  ? item['image'][0]
                  : 'https://img.myipadbox.com/upload/store/product_l/$itemNo.jpg',
              offer: item['prices']['discount'].toString(),
              returnday: '7',
              count: quantity.toString(),
              totalValue: calculatedPrice * quantity,
              reviews: '',
              removePress: () async {
                final cartBox = Hive.box('cartBox');
                var existingCartRaw = cartBox.get('cart');

                if (existingCartRaw != null) {
                  Map<String, dynamic> existingCart =
                      Map<String, dynamic>.from(existingCartRaw);

                  List<dynamic> items = existingCart['items'];
                  items.removeWhere(
                      (element) => element['itemNo'] == item['itemNo']);

                  double updatedCartTotal =
                      items.fold(0.0, (total, currentItem) {
                    var priceList = currentItem['priceList'] ?? [];
                    // var itemNo = currentItem['itemNo'];
                    var quantity =
                        int.tryParse(currentItem['quantity'].toString()) ?? 1;

                    int itemPrice = calculatePriceFromList(quantity, priceList,
                        isCustomProduct: isCustomProduct);

                    return total + (itemPrice * quantity);
                  });

                  existingCart['items'] = items;
                  existingCart['cartTotal'] = updatedCartTotal;
                  existingCart['totalItems'] = items.length;

                  await cartBox.put('cart', existingCart);

                  setState(() {
                    cartItems =
                        items.map((e) => Map<String, dynamic>.from(e)).toList();
                    cartTotal = updatedCartTotal.toInt();
                    totalItems = items.length;
                  });
                }
              },
              onIncreaseQuantity: () => updateQuantity(itemNo, increase: true),
              onDecreaseQuantity: () => updateQuantity(itemNo, increase: false),
            ),
          );
        }).toList(),
      ),
    );
  }

  int calculatePriceFromList(int quantity, List<dynamic> priceList,
      {required bool isCustomProduct}) {
    double priceMultiplier = 1.87;

    priceList.sort((a, b) => (a['key'] as int).compareTo(b['key'] as int));

    for (var priceEntry in priceList) {
      int key = priceEntry['key'];
      double value = double.tryParse(priceEntry['value'].toString()) ?? 1.87;

      if (quantity >= key) {
        priceMultiplier = value;
      } else {
        break;
      }
    }

    if (isCustomProduct) {
      return priceMultiplier.round();
    }

    double convertedPrice = priceMultiplier * 85;

    return convertedPrice.round();
  }

  Widget _buildBottomPriceDetails(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(top: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPriceHeader(context),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildPriceRow(
                        context, 'Price ($totalItems Items)', '₹$cartTotal'),
                    const SizedBox(height: 4),
                    _buildPriceRow(context, 'Delivery Charges', 'Free Delivery',
                        valueColor: IKColors.success),
                  ],
                ),
              ),
              _buildTotalAmount(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Text(
        'Price Details',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, String value,
      {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.merge(const TextStyle(fontWeight: FontWeight.w400))),
        Text(value,
            style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(
                color: valueColor ?? Colors.black,
                fontWeight: FontWeight.w400))),
      ],
    );
  }

  Widget _buildTotalAmount(BuildContext context) {
    int totalAmount = cartTotal;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount', style: Theme.of(context).textTheme.titleLarge),
          Text('₹$totalAmount',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.merge(const TextStyle(color: IKColors.success))),
        ],
      ),
    );
  }

  void calculateCartTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['totalAmount']; // Sum of each product's total amount
    }
    setState(() {
      grandTotal = total;
    });
  }
}
