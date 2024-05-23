import 'package:clickcart/components/list/list_item.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  const Profile({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(IKImages.logo,height: 24,),
        titleSpacing: 5,
        leading: IconButton(
          onPressed: () {},
          iconSize: 28,
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            iconSize: 28,
            icon: const Icon(Icons.search)
          ),
          IconButton(
            onPressed: () {}, 
            iconSize: 28,
            icon: const Icon(Icons.notifications_none)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child : Image.asset(IKImages.profile,height: 40,width: 40),
                      ),
                      const SizedBox(width: 15),
                      Text('James Smith',style: Theme.of(context).textTheme.headlineLarge?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 17.5,
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(11),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                        ),
                        child: Text('Your order',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 17.5,
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(11),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                        ),
                        child: Text('Wishlist',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 17.5,
                        padding: const EdgeInsets.all(11),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                        ),
                        child: Text('Coupons',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 17.5,
                        padding: const EdgeInsets.all(11),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                        ),
                        child: Text('Track order',style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              color: Theme.of(context).cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                    ),
                    child: Text('Account Settings',style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.profile,
                            width: 20,
                            height: 20,
                          ),
                          title: "Edit profile",
                        ),
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.card,
                            width: 20,
                            height: 20,
                          ),
                          title: "Saved Cards & Wallet",
                        ),
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.address,
                            width: 20,
                            height: 20,
                          ),
                          title: "Saved Addresses",
                        ),
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.language,
                            width: 20,
                            height: 20,
                          ),
                          title: "Select Language",
                        ),
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.bell,
                            width: 20,
                            height: 20,
                          ),
                          title: "Notifications Settings",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                    ),
                    child: Text('My Activity',style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.review,
                            width: 20,
                            height: 20,
                          ),
                          title: "Reviews",
                        ),
                        ListItem(
                          icon: SvgPicture.string(
                            IKSvg.comment,
                            width: 20,
                            height: 20,
                          ),
                          title: "Questions & Answers",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}