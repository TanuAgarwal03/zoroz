import 'package:clickcart/components/drawer/drawer_menu.dart';
import 'package:clickcart/components/list/list_item.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  const Profile({ super.key });

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
              title: Image.asset(IKImages.logo,height: 24,),
              titleSpacing: 5,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    iconSize: 28,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search_screen');
                  }, 
                  iconSize: 28,
                  icon: SvgPicture.string(IKSvg.search),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat_list');
                      }, 
                      iconSize: 28,
                      // ignore: deprecated_member_use
                      icon: SvgPicture.string(IKSvg.chat,height: 20,width: 20, color: Colors.white),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: IKColors.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text('14',style: TextStyle(color: Colors.black,fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
      drawer: const DrawerMenu(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: SingleChildScrollView(
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/my_orders');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width > IKSizes.container ?
                                IKSizes.container / 2 - 17.5
                                :
                                MediaQuery.of(context).size.width / 2 - 17.5,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(11),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                              ),
                              child: Text('Your order',style: Theme.of(context).textTheme.titleLarge),
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/wishlist');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width > IKSizes.container ?
                                IKSizes.container / 2 - 17.5
                                :
                                MediaQuery.of(context).size.width / 2 - 17.5,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(11),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                              ),
                              child: Text('Wishlist',style: Theme.of(context).textTheme.titleLarge),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/coupons');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width > IKSizes.container ?
                                IKSizes.container / 2 - 17.5
                                :
                                MediaQuery.of(context).size.width / 2 - 17.5,
                              padding: const EdgeInsets.all(11),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                              ),
                              child: Text('Coupons',style: Theme.of(context).textTheme.titleLarge),
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/track_order');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width > IKSizes.container ?
                                IKSizes.container / 2 - 17.5
                                :
                                MediaQuery.of(context).size.width / 2 - 17.5,
                              padding: const EdgeInsets.all(11),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                              ),
                              child: Text('Track order',style: Theme.of(context).textTheme.titleLarge),
                            ),
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
                              onTap: (){
                                Navigator.pushNamed(context, '/edit_profile');
                              },
                              icon: SvgPicture.string(
                                IKSvg.profile,
                                width: 20,
                                height: 20,
                              ),
                              title: "Edit profile",
                            ),
                            ListItem(
                              onTap: (){
                                Navigator.pushNamed(context, '/payment');
                              },
                              icon: SvgPicture.string(
                                IKSvg.card,
                                width: 20,
                                height: 20,
                              ),
                              title: "Saved Cards & Wallet",
                            ),
                            ListItem(
                              onTap: (){
                                Navigator.pushNamed(context, '/delivery_address');
                              },
                              icon: SvgPicture.string(
                                IKSvg.address,
                                width: 20,
                                height: 20,
                              ),
                              title: "Saved Addresses",
                            ),
                            ListItem(
                              onTap: (){
                                Navigator.pushNamed(context, '/choose_language');
                              },
                              icon: SvgPicture.string(
                                IKSvg.language,
                                width: 20,
                                height: 20,
                              ),
                              title: "Select Language",
                            ),
                            ListItem(
                              onTap: (){
                                Navigator.pushNamed(context, '/notifications');
                              },
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
                              onTap: (){
                                Navigator.pushNamed(context, '/write_review');
                              },
                              icon: SvgPicture.string(
                                IKSvg.review,
                                width: 20,
                                height: 20,
                              ),
                              title: "Reviews",
                            ),
                            ListItem(
                              onTap: (){
                                Navigator.pushNamed(context, '/questions');
                              },
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
        ),
      ),
    );
  }
}