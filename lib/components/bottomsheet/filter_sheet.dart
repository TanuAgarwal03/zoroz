import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class CategoryItem {
  String title;
  CategoryItem({required this.title});
}
class SizeItem {
  String title;
  SizeItem({required this.title});
}
class BrandItem {
  String image;
  BrandItem({required this.image});
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({ super.key });

  @override
  // ignore: library_private_types_in_public_api
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {

  String _selectedCategory = "All";
  String _selectedSize = "S";
  String _selectedBrand = IKImages.brand1;

  RangeValues _currentRangeValues = const RangeValues(200, 280);

  // ignore: non_constant_identifier_names
  List<CategoryItem> Categories = [
    CategoryItem(title: "All"),
    CategoryItem(title: "Face Wash"),
    CategoryItem(title: "Cleanser"),
    CategoryItem(title: "Scrubs"),
    CategoryItem(title: "Makeup Remover"),
    CategoryItem(title: "Hand Cream"),
  ];

  // ignore: non_constant_identifier_names
  List<SizeItem> Sizes = [
    SizeItem(title: "S"),
    SizeItem(title: "M"),
    SizeItem(title: "L"),
    SizeItem(title: "XL"),
    SizeItem(title: "2XL"),
  ];

  // ignore: non_constant_identifier_names
  List<BrandItem> Brands = [
    BrandItem(image: IKImages.brand1),
    BrandItem(image: IKImages.brand2),
    BrandItem(image: IKImages.brand3),
    BrandItem(image: IKImages.brand4),
    BrandItem(image: IKImages.brand5),
    BrandItem(image: IKImages.brand6),
    BrandItem(image: IKImages.brand7),
    BrandItem(image: IKImages.brand8),
    BrandItem(image: IKImages.brand9),
    BrandItem(image: IKImages.brand10),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 635,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15,top: 2,bottom: 2,right: 5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Filters',style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  onPressed: () => Navigator.pop(context), 
                  icon: Icon(Icons.close,color: Theme.of(context).textTheme.titleMedium?.color)
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Brand',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15))),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/main_home');
                        }, 
                        child: Text('See All',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: IKColors.primary))),
                      )
                    ],
                  ),
                  Wrap(
                    children: Brands.map((item) {
                      return GestureDetector(
                        onTap: (){ 
                          setState(() {
                            _selectedBrand = item.image;
                          });
                        },
                        child : Container(
                          margin: const EdgeInsets.only(right: 5,bottom: 5),
                          padding:const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: _selectedBrand == item.image ? IKColors.primary : Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Image.asset(item.image,height: 45,width: 45),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories:',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15))),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/main_home');
                        }, 
                        child: Text('See All',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: IKColors.primary))),
                      )
                    ],
                  ),
                  Wrap(
                    children: Categories.map((item) {
                      return GestureDetector(
                        onTap: (){ 
                          setState(() {
                            _selectedCategory = item.title;
                          });
                        },
                        child : Container(
                          margin: const EdgeInsets.only(right: 5,bottom: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedCategory == item.title ? IKColors.primary : Colors.transparent,
                            border: Border.all(width: 1, color: _selectedCategory == item.title ? IKColors.primary : Theme.of(context).dividerColor),
                          ),
                          child: Text(item.title,style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle( fontSize: 13,color: _selectedCategory == item.title ? Colors.white : Theme.of(context).textTheme.titleMedium?.color))),
                        )
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Size:',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15))),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/main_home');
                        }, 
                        child: Text('See All',style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: IKColors.primary))),
                      )
                    ],
                  ),
                  Wrap(
                    children: Sizes.map((item) {
                      return GestureDetector(
                        onTap: (){ 
                          setState(() {
                            _selectedSize = item.title;
                          });
                        },
                        child : Container(
                          margin: const EdgeInsets.only(right: 5,bottom: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedSize == item.title ? IKColors.primary : Colors.transparent,
                            border: Border.all(width: 1, color: _selectedSize == item.title ? IKColors.primary : Theme.of(context).dividerColor),
                          ),
                          child: Text(item.title,style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle( fontSize: 13,color: _selectedSize == item.title ? Colors.white : Theme.of(context).textTheme.titleMedium?.color))),
                        )
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15))),
                    ],
                  ),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 150,
                    max: 300,
                    divisions: 100,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    activeColor: IKColors.primary,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ],
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1,color: Theme.of(context).dividerColor))
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      backgroundColor:Colors.transparent,
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ), 
                    child: const Text('Reset',style: TextStyle(color: IKColors.primary)),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context), 
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8)
                    ),
                    child: const Text('Apply'),
                  ),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}