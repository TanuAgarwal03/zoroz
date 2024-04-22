import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/screens/cart/cart.dart';
import 'package:clickcart/screens/category/category.dart';
import 'package:clickcart/screens/home/home.dart';
import 'package:clickcart/screens/profile/profile.dart';
import 'package:clickcart/screens/wishlist/wishlist.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({ super.key });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    Home(),
    Category(),
    Cart(),
    Wishlist(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 2,color: Theme.of(context).dividerColor)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child : BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2,top: 4),
                child: SvgPicture.string(
                  IKSvg.home,
                  width: 20,
                  height: 20,
                  color: _selectedIndex == 0 ? IKColors.primary : IKColors.title,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2,top: 4),
                child: SvgPicture.string(
                  IKSvg.category,
                  width: 20,
                  height: 20,
                  color: _selectedIndex == 1 ? IKColors.primary : IKColors.title,
                ),
              ),
              label: 'Menus',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2,top: 4),
                child: SvgPicture.string(
                  IKSvg.cart,
                  width: 20,
                  height: 20,
                  color: _selectedIndex == 2 ? IKColors.primary : IKColors.title,
                ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2,top: 4),
                child: SvgPicture.string(
                  IKSvg.wishlist,
                  width: 20,
                  height: 20,
                  color: _selectedIndex == 3 ? IKColors.primary : IKColors.title,
                ),
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2,top: 4),
                // child: Container(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(IKImages.profile,height: 20,width: 20),
                ),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
