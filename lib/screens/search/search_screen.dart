import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({ super.key });

  final List<String> searchTags = [
    'Mobiles',
    'Electronics',
    'Camera',
    'Headphone',
    'TVs & LED',
    'Furniture',
    'Mobiles',
    'Electronics',
    'Camera',
    'Headphone',
    'TVs & LED',
    'Furniture',
  ];

  @override
  Widget build(BuildContext context){
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: IKColors.primary,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Best items for You',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    contentPadding: const EdgeInsets.all(18),
                    prefixIcon: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.arrow_back,color: Theme.of(context).textTheme.bodyMedium?.color)
                    ),
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerColor,width: 2.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: IKColors.primary,width: 2.0)
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/products');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.string(
                                        IKSvg.time,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child : Text('iPhone Mobile',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                                      ),
                                      SvgPicture.string(
                                        IKSvg.arrowup,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/products');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      SvgPicture.string(
                                        IKSvg.time,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child : Text('Headphone',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(fontWeight: FontWeight.w400))),
                                      ),
                                      SvgPicture.string(
                                        IKSvg.arrowup,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
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
                                padding: const EdgeInsets.only(left: 15,right: 5,top: 2,bottom: 2),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Discover More',style: Theme.of(context).textTheme.titleLarge),
                                    TextButton(
                                      onPressed: (){}, 
                                      child: Text('Clear All',style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: IKColors.primary))),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Wrap(
                                  children: searchTags.map((data) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/products');
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 4,right: 4),
                                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 7),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Theme.of(context).dividerColor)
                                        ),
                                        child: Text(data,style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400,fontSize: 13))),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}