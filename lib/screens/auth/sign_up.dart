import 'package:clickcart/screens/auth/otp.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<String> selectedCategories = [];
  List<String> productList = [];
  List<String> categoryList = [];
  List<dynamic> selectedProducts = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    final response = await http
        .get(Uri.parse('https://backend.vansedemo.xyz/api/products/all'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        productList = List<String>.from(data['products'].map((p) => p['name']));
      });
    }
  }

  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://backend.vansedemo.xyz/api/categories/all'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        categoryList =
            List<String>.from(data['categories'].map((c) => c['name']));
      });
    }
  }

  void onProductsChanged(List<dynamic> products) {
    setState(() {
      selectedProducts = products;
    });
    print(
        'Selected Products: ${selectedProducts.map((p) => p['_id']).toList()}');
  }

  void submitForm() {
    List<dynamic> selectedProductIds =
        selectedProducts.map((p) => p['_id']).toList();

    print('Name: $_nameController');
    print('Email: $_emailController');
    print('Phone: $_phoneController');
    print('Selected Products: $selectedProductIds');
  }

  Future<void> sendVerification() async {
    setState(() => isLoading = true);

    final url = Uri.parse(
        'https://backend.vansedemo.xyz/api/customer/verificationSend');
    final body = {
      "phone": _phoneController.text,
      "name": _nameController.text,
      "email": _emailController.text,
      "products": selectedProducts,
      "categories": selectedCategories
    };

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Otp(phoneNumber: _phoneController.text),
            ),
          );
          print("Success: $data");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
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
          print('${response.statusCode} Status is false');
        }
      } else {
        print("Failed: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${response.body}'),
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
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Something went wrong!'),
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

  void showMultiSelect({
    required List<String> items,
    required List<String> selectedItems,
    required String title,
    required Function(List<String>) onSelectionChanged,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final tempSelected = List<String>.from(selectedItems);

        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: items
                  .map((item) => CheckboxListTile(
                        value: tempSelected.contains(item),
                        title: Text(item),
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked == true) {
                              tempSelected.add(item);
                            } else {
                              tempSelected.remove(item);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                onSelectionChanged(tempSelected);
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
        child: Container(
          color: IKColors.primary,
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: IKSizes.container),
            child: AppBar(
              title: const Text("Create Account"),
            ),
          ),
        ),
      ),
      body: Container(
        color: IKColors.primary,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: IKSizes.container),
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Fresh arrival, ready to explore?',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 6),
                          Text('Register using your phone number to begin',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 15),

                          // Name Field
                          Text('Your Name',
                              style: Theme.of(context).textTheme.labelMedium),
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              contentPadding: const EdgeInsets.all(15),
                              prefixIcon: const Icon(Icons.person,
                                  color: IKColors.primary),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 2.0),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: IKColors.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          Text('Enter Mobile number',
                              style: Theme.of(context).textTheme.labelMedium),
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              contentPadding: const EdgeInsets.all(15),
                              prefixIcon: const Icon(Icons.phone,
                                  color: IKColors.primary),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 2.0),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: IKColors.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),

                          Text('Email Id',
                              style: Theme.of(context).textTheme.labelMedium),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              contentPadding: const EdgeInsets.all(15),
                              prefixIcon: const Icon(Icons.email,
                                  color: IKColors.primary),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                    width: 2.0),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: IKColors.primary, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          MultiSelectProductSearch(
                              onSelectionChanged: onProductsChanged),

                          const SizedBox(height: 12),
                          MultiSelectCategorySearch(
                            onSelectionChanged: (selectedCategories) {
                              print('Selected Categories: $selectedCategories');
                            },
                          ),

                          RichText(
                            text: TextSpan(
                              text: "By continuing, you agree to Zoroz",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.merge(const TextStyle(
                                      fontWeight: FontWeight.w400)),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' Terms of Use',
                                    style: TextStyle(
                                        color: IKColors.primary,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(text: ' and'),
                                TextSpan(
                                    text: ' Privacy Policy.',
                                    style: TextStyle(
                                        color: IKColors.primary,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Actions
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Existing User?",
                          style: Theme.of(context).textTheme.titleMedium?.merge(
                              const TextStyle(fontWeight: FontWeight.w400)),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Login',
                                style: const TextStyle(
                                    color: IKColors.primary,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(context, '/signin');
                                  }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Continue Button
                      ElevatedButton(
                        onPressed: isLoading ? null : sendVerification,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: IKColors.secondary,
                            side: const BorderSide(color: IKColors.secondary),
                            foregroundColor: IKColors.title),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Continue',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelectProductSearch extends StatefulWidget {
  final Function(List<String>) onSelectionChanged; // Now List<String>
  const MultiSelectProductSearch({super.key, required this.onSelectionChanged});
  @override
  _MultiSelectProductSearchState createState() =>
      _MultiSelectProductSearchState();
}

class _MultiSelectProductSearchState extends State<MultiSelectProductSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  final List<String> _selectedProductTitles = []; // Now only store titles
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final text = _searchController.text;
      if (text.isEmpty) {
        setState(() {
          _searchResults.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchSearchResults(String searchValue) async {
    final String url =
        'https://backend.vansedemo.xyz/api/products/store?title=$searchValue';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> products = data['products'];
        setState(() {
          _searchResults = products;
        });
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void addProduct(dynamic product) {
    String productTitle = product['title']['en'] ?? '';

    if (!_selectedProductTitles.contains(productTitle)) {
      setState(() {
        _selectedProductTitles.add(productTitle);
      });

      widget.onSelectionChanged(_selectedProductTitles);
    }

    _searchController.clear(); // Clears text
    FocusScope.of(context).unfocus(); // Hides keyboard

    setState(() {
      _searchResults.clear(); // Clears suggestions
    });
  }

  void removeProduct(String productTitle) {
    setState(() {
      _selectedProductTitles.remove(productTitle);
    });

    widget.onSelectionChanged(_selectedProductTitles);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search Products',
            suffixIcon: _isSearching
                ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : const Icon(Icons.search),
          ),

          onChanged: (value) async {
            if (value.isNotEmpty) {
              setState(() {
                _isSearching = true;
              });
              await fetchSearchResults(value);
              setState(() {
                _isSearching = false;
              });
            } else {
              setState(() {
                _searchResults.clear();
              });
            }
          },

//           onChanged: (value) async {
//   if (value.isNotEmpty) {
//     setState(() {
//       _isSearching = true;
//     });
//     await fetchSearchResults(value);
//     setState(() {
//       _isSearching = false;
//     });
//   } else {
//     setState(() {
//       _searchResults.clear();
//     });
//   }
// },
        ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 5),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4)
              ],
            ),
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ListTile(
                  title: Text(product['title']['en'] ?? 'No title'),
                  onTap: () => addProduct(product),
                );
              },
            ),
          ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _selectedProductTitles.map((title) {
            return Chip(
              label: Text(title),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => removeProduct(title),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MultiSelectCategorySearch extends StatefulWidget {
  final Function(List<String>) onSelectionChanged; // Callback to parent
  const MultiSelectCategorySearch(
      {super.key, required this.onSelectionChanged});

  @override
  _MultiSelectCategorySearchState createState() =>
      _MultiSelectCategorySearchState();
}

class _MultiSelectCategorySearchState extends State<MultiSelectCategorySearch> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  final List<String> _selectedCategories = [];
  bool _isSearching = false;

  /// Fetch categories from the API
  Future<void> fetchSearchResults(String searchValue) async {
    const String url =
        'https://backend.vansedemo.xyz/api/category/searchCategory';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'searchtext': searchValue}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<String> categories = List<String>.from(data);

        setState(() {
          _searchResults = categories;
        });
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  /// Add selected category to the chip list
  void addCategory(String categoryName) {
    if (!_selectedCategories.contains(categoryName)) {
      setState(() {
        _selectedCategories.add(categoryName);
      });

      widget.onSelectionChanged(_selectedCategories);
    }

    _searchController.clear();
    setState(() {
      _searchResults.clear();
    });
  }

  /// Remove category from the chip list
  void removeCategory(String categoryName) {
    setState(() {
      _selectedCategories.remove(categoryName);
    });

    widget.onSelectionChanged(_selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search Categories',
            suffixIcon: _isSearching
                ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : const Icon(Icons.search),
          ),
          onChanged: (value) async {
            if (value.isNotEmpty) {
              setState(() {
                _isSearching = true;
              });
              await fetchSearchResults(value);
              setState(() {
                _isSearching = false;
              });
            } else {
              setState(() {
                _searchResults.clear();
              });
            }
          },
        ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 5),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4)
              ],
            ),
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final category = _searchResults[index];
                return ListTile(
                  title: Text(category),
                  onTap: () => addCategory(category),
                );
              },
            ),
          ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _selectedCategories.map((category) {
            return Chip(
              label: Text(category),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => removeCategory(category),
            );
          }).toList(),
        ),
      ],
    );
  }
}
