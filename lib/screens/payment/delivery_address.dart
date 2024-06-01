import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressItem {
  String icon;
  String title;
  String address;

  AddressItem({required this.icon ,required this.title , required this.address});
}

class DeliveryAddress extends StatefulWidget {

  const DeliveryAddress({ super.key });

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {

  String _selectedValue = "e4";

  // ignore: non_constant_identifier_names
  List<AddressItem> Addresses = [
    AddressItem(icon: IKSvg.home,title: "Home Address",address: '123 Main Street, Anytown, USA 12345'),
    AddressItem(icon: IKSvg.mapmarker,title: "Office Address",address: '456 Elm Avenue, Smallville, CA 98765'),
    AddressItem(icon: IKSvg.home,title: "Work Address",address: '789 Maple Lane, Suburbia, NY 54321'),
    AddressItem(icon: IKSvg.shop,title: "Shop Address",address: '654 Pine Road, Countryside, FL 34567'),
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
              title: const Text('Delivery Address'),
              titleSpacing: 5,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('4 address',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white)),
                )
              ],
            ),
          ),
        )
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                child : Row(
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: IKColors.primary,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: const Text('1',textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500)),
                    ),
                    Text('Cart',style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: IKColors.primary))
                        ),
                      )
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: IKColors.primary,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: const Text('2',textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500)),
                    ),
                    Text('Address',style: Theme.of(context).textTheme.titleMedium),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: Theme.of(context).dividerColor))
                        ),
                      )
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      padding: const EdgeInsets.only(bottom: 0),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(9)
                      ),
                      child: Text('3',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleSmall),
                    ),
                    Text('Payment',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontWeight: FontWeight.w500))),
                  ],
                )
              ),
              Expanded(
                child : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: Addresses.map((item) {
                                return AddressView(
                                  data: item,
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            GestureDetector(
                              onTap: (){ 
                                Navigator.pushNamed(context, '/add_delivery_address');
                              },
                              child : Container(
                                height: 48,
                                color: Theme.of(context).dividerColor,
                                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                                margin: const EdgeInsets.only(bottom: 12,top: 18),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_circle_outline,color:IKColors.primary),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text('Add Address', style: Theme.of(context).textTheme.titleMedium)
                                    ),
                                    Icon(Icons.arrow_forward_ios,size: 16,color: Theme.of(context).textTheme.titleLarge?.color)
                                  ],  
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
                    Navigator.pushNamed(context, '/payment');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IKColors.secondary,
                    side: const BorderSide(color: IKColors.secondary),
                    foregroundColor: IKColors.title
                  ),
                  child: const Text('Continue'),
                ),
              )
            ]
          ),
        ),
      )
    );
  }
}

class AddressView extends StatelessWidget {

  final AddressItem data;
  final String groupValue;
  final Function onChanged;

  const AddressView({super.key,  required this.data , required this.groupValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ onChanged(data.title); },
      child : Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Theme.of(context).dividerColor)
              ),
              alignment: Alignment.center,
              child: SvgPicture.string(
                data.icon,
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
                  Text(data.title,style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(data.address,style: Theme.of(context).textTheme.bodyMedium),
                ],
              ) 
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                border: Border.all(width: 5,color: groupValue == data.title ? IKColors.primary : Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
