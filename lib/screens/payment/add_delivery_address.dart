import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AddressItem {
  String title;

  AddressItem({required this.title});
}

class AddDeliveryAddress extends StatefulWidget {

  const AddDeliveryAddress({ super.key });

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {

  String _selectedValue = "Home";

  // ignore: non_constant_identifier_names
  List<AddressItem> Addresses = [
    AddressItem(title: "Home"),
    AddressItem(title: "Shop"),
    AddressItem(title: "Office"),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: const Text('Add Delivery Address'),
              titleSpacing: 5,
              centerTitle: true,
            ),
          ),
        )
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child : SingleChildScrollView( 
                  child : Column(
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
                                border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                              ),
                              child: Text('Contact Details',style: Theme.of(context).textTheme.headlineMedium)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Full Name',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Mobile No.',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
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
                                border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                              ),
                              child: Text('Address',style: Theme.of(context).textTheme.headlineMedium)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Pin Code',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      keyboardType: TextInputType.number,
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Address',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Locality/Town',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'City/District',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'State',
                                        labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                        floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                      ),
                                      cursorColor: IKColors.primary,
                                      style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
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
                        margin: const EdgeInsets.only(top: 12, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                              ),
                              child: Text('Save Address As',style: Theme.of(context).textTheme.headlineMedium)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Wrap(
                                children: Addresses.map((item) {
                                return GestureDetector(
                                  onTap: (){ 
                                    setState(() {
                                      _selectedValue = item.title;
                                    });
                                  },
                                  child : Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                    decoration: BoxDecoration(
                                      color: _selectedValue == item.title ? IKColors.primary : Colors.transparent,
                                      border: Border.all(width: 1, color: _selectedValue == item.title ? IKColors.primary : Theme.of(context).dividerColor),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(item.title,style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle( color: _selectedValue == item.title ? Colors.white : Theme.of(context).textTheme.titleMedium?.color))),
                                  )
                                );
                              }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ),
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
                    Navigator.pushNamed(context, '/delivery_address');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IKColors.secondary,
                    side: const BorderSide(color: IKColors.secondary),
                    foregroundColor: IKColors.title
                  ),
                  child: const Text('Save Address'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}