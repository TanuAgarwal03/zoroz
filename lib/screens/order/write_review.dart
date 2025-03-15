import 'package:clickcart/components/product/product_card_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({ super.key });

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  double value = 3.5;

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
              title: const Text('Write Review'),
              titleSpacing: 5,
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const ProductCardList(
                        title: 'APPLE iPhone 14 (Blue, 128 GB)', 
                        price: '105', 
                        oldPrice: '112', 
                        image: IKImages.product1, 
                        returnday: '14', 
                        count: "count", 
                        offer: '70% OFF', 
                        reviews: '132',
                        productid : '#22344862',
                        wishlistIcon : false,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10,bottom: 10),
                        color: Theme.of(context).cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor))
                              ),
                              child: Text('Overall Rating',style: Theme.of(context).textTheme.titleLarge),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Your average rating is 4.0',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                                  const SizedBox(height: 8),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    unratedColor: Theme.of(context).dividerColor,
                                    itemCount: 5,
                                    itemSize: 28.0,
                                    itemBuilder: (context, _) => const Icon(Icons.star,color: Color(0xFFFFA048),),
                                    onRatingUpdate: (rating) {
                                      
                                    },
                                    updateOnDrag: true,
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Review Title',
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
                                        labelText: 'Product Review',
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
                                  Text('Would you recommend this product to a friend?',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
                                  const RadioExample(),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IKColors.secondary,
                    side: const BorderSide(color: IKColors.secondary),
                    foregroundColor: IKColors.title
                  ),
                  child: const Text('Submit Review'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum SingingCharacter { yes, no }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.yes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row( 
          children: [
              Radio<SingingCharacter>(
                value: SingingCharacter.yes,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
                activeColor: IKColors.primary,
              ),
              Text('Yes',style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Row(
          children: [
            Radio<SingingCharacter>(
              value: SingingCharacter.no,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
              activeColor: IKColors.primary,
            ),
            Text('No',style: Theme.of(context).textTheme.titleLarge),
          ]
        ),
      ],
    );
  }
}