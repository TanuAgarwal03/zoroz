import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Checkout extends StatelessWidget {
  const Checkout({ super.key });

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
              title: const Text('Checkout'),
              centerTitle: true,
              titleSpacing: 5,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Theme.of(context).cardColor,
                        child : Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
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
                                        Text('Delivery address',style: Theme.of(context).textTheme.titleLarge),
                                        const SizedBox(height: 4),
                                        Text('123 Main Street, Anytown, USA 12345',style: Theme.of(context).textTheme.bodyMedium),
                                      ],
                                    ) 
                                  ),
                                  Icon(Icons.chevron_right,color: Theme.of(context).textTheme.titleMedium?.color)
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
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
                                        Text('Payment',style: Theme.of(context).textTheme.titleLarge),
                                        const SizedBox(height: 4),
                                        Text('XXXX XXXX XXXX 3456',style: Theme.of(context).textTheme.bodyMedium),
                                      ],
                                    ) 
                                  ),
                                  Icon(Icons.chevron_right,color: Theme.of(context).textTheme.titleMedium?.color)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Additional Notes:',style:Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400,fontSize: 15))),
                                  TextFormField(
                                    maxLines: 2,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'Write Here',
                                      labelStyle: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(fontSize: 15)),
                                      floatingLabelStyle: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.primary)), 
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
                                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(width: 2,color: IKColors.primary)),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                    ),
                                    cursorColor: IKColors.primary,
                                    style: TextStyle(color: Theme.of(context).textTheme.titleMedium?.color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Theme.of(context).cardColor,
                        margin: const EdgeInsets.only(top: 5,bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              child: Text('Price Details',style: Theme.of(context).textTheme.titleLarge),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Price (5 Items)',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                                      Text('\$21299',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Discount',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                                      Text('\$4000',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Delivery Charges',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                                      Text('Free Delivery',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: IKColors.success,fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Amount',style:Theme.of(context).textTheme.titleLarge),
                                  Text('\$17299',style:Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: IKColors.success)))
                                ],
                              ),
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
                ),
                child: ElevatedButton(
                  onPressed: () { 
                    Navigator.pushNamed(context, '/main_home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IKColors.secondary,
                    side: const BorderSide(color: IKColors.secondary),
                    foregroundColor: IKColors.title
                  ),
                  child: const Text('Submit Order'),
                ),
              )    
            ],
          ),
        ),
      ),
    );
  }
}