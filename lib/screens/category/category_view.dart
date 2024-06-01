import 'package:clickcart/components/category/category_item.dart';
import 'package:clickcart/components/home/category_list.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryView extends StatelessWidget {
  CategoryView({ super.key });

  final List<Map<String, String>> categoryItems = [
    {'title': 'Mobiles', 'image': IKImages.cat1},
    {'title': 'Electronics', 'image': IKImages.cat2},
    {'title': 'Camera', 'image': IKImages.cat3},
    {'title': 'Headphone', 'image': IKImages.cat4},
    {'title': 'TVs & LED', 'image': IKImages.cat5},
    {'title': 'Furniture', 'image': IKImages.cat6},
  ];

  final List<Map<String, String>> televisions = [
    {'title': 'Samsung', 'image': IKImages.tel1},
    {'title': 'Sony', 'image': IKImages.tel2},
    {'title': 'Acer', 'image': IKImages.tel3},
    {'title': 'LG', 'image': IKImages.tel4},
    {'title': 'Acer', 'image': IKImages.tel3},
    {'title': 'LG', 'image': IKImages.tel4},
    {'title': 'Sony', 'image': IKImages.tel2},
    {'title': 'More'},
  ];
  final List<Map<String, String>> cameras = [
    {'title': 'Cameras', 'image': IKImages.cam1},
    {'title': 'DSLR', 'image': IKImages.cam2},
    {'title': 'Accessories', 'image': IKImages.cam3},
    {'title': 'More'},
  ];
  final List<Map<String, String>> accessories = [
    {'title': 'Mouse', 'image': IKImages.mouse},
    {'title': 'LED', 'image': IKImages.led},
    {'title': 'Keyboard', 'image': IKImages.keyboard},
    {'title': 'More'},
  ];

  final List<Map<String, String>> brands = [
    {'image': IKImages.brand1},
    {'image': IKImages.brand2},
    {'image': IKImages.brand3},
    {'image': IKImages.brand4},
    {'image': IKImages.brand5},
    {'image': IKImages.brand6},
    {'image': IKImages.brand7},
    {'image': IKImages.brand8},
    {'image': IKImages.brand9},
    {'image': IKImages.brand10},
  ];

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryItems.map((item) {
                    return CategoryItem(item['title']!, item['image']!);
                  }).toList(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  child: Text('Televisions',style: Theme.of(context).textTheme.titleMedium),
                ), 
                Wrap(
                  children: televisions.map((item){  
                    if(item['title'] == 'More'){
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            IKSizes.container / 4
                            :
                            MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.all(4),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.string(IKSvg.grid,height: 24,width: 24),
                              ),
                              Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 13,color: IKColors.primary))),
                            ],
                          ),
                        ),
                      );
                    }else{
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            IKSizes.container / 4
                            :
                            MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.all(4),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(item['image']!,height: double.maxFinite,width: double.maxFinite,),
                              ),
                              Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400,fontSize: 13))),
                            ],
                          ),
                        ),
                      );
                    }
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  child: Text('Camera',style: Theme.of(context).textTheme.titleMedium),
                ), 
                Wrap(
                  children: cameras.map((item){  
                    if(item['title'] == 'More'){
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            IKSizes.container / 4
                            :
                            MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.all(4),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.string(IKSvg.grid,height: 24,width: 24),
                              ),
                              Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 13,color: IKColors.primary))),
                            ],
                          ),
                        ),
                      );
                    }else{
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            IKSizes.container / 4
                            :
                            MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.all(4),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(item['image']!,height: double.maxFinite,width: double.maxFinite,),
                              ),
                              Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400,fontSize: 13))),
                            ],
                          ),
                        ),
                      );
                    }
                  }).toList(),
                ),
              ],
            ),
          ),
          CategoryList(),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  child: Text('Computer Accessories',style: Theme.of(context).textTheme.titleMedium),
                ), 
                Wrap(
                  children: accessories.map((item){  
                    if(item['title'] == 'More'){
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            IKSizes.container / 4
                            :
                            MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.all(4),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.string(IKSvg.grid,height: 24,width: 24),
                              ),
                              Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 13,color: IKColors.primary))),
                            ],
                          ),
                        ),
                      );
                    }else{
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            IKSizes.container / 4
                            :
                            MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                padding: const EdgeInsets.all(4),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(item['image']!,height: double.maxFinite,width: double.maxFinite,),
                              ),
                              Text(item['title']!,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400,fontSize: 13))),
                            ],
                          ),
                        ),
                      );
                    }
                  }).toList(),
                ),
              ],
            ),
          ),
          Image.asset(IKImages.banner1,width: double.infinity),
          Container(
            margin: const EdgeInsets.only(top: 10,bottom: 15),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  child: Text('Brands',style: Theme.of(context).textTheme.titleMedium),
                ), 
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                  child: Wrap(
                    children: brands.map((item){  
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10,left: 5,right: 5),
                          padding: const EdgeInsets.all(4),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(item['image']!,height: double.maxFinite,width: double.maxFinite,),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}