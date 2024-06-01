import 'package:clickcart/screens/category/category_view.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category extends StatelessWidget {

  Category({ super.key });

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'MOBILE'
    },
    {
      'title': 'FASHION'
    },
    {
      'title': 'ELECTRONICS'
    },
    {
      'title': 'BEAUTY'
    },
    {
      'title': 'HOME & FURNITURE'
    },
  ];

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: const Text('Categories'),
              titleSpacing: 5,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search_screen');
                  }, 
                  iconSize: 28,
                  icon: SvgPicture.string(IKSvg.search),
                ),
              ],
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: DefaultTabController(
            length: categories.length,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: TabBarView(
                    children: [
                      CategoryView(),
                      CategoryView(),
                      CategoryView(),
                      CategoryView(),
                      CategoryView(),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: TabBar( 
                      isScrollable: true,
                      indicatorWeight: 4,
                      indicatorColor: IKColors.primary,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w500
                      ),
                      dividerHeight: 0,
                      labelColor: IKColors.primary,
                      unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
                      tabs: categories.map((item) {
                        return Tab(
                          child: Text(item['title']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}