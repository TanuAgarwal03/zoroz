// import 'dart:convert';

// import 'package:card_swiper/card_swiper.dart';
// import 'package:clickcart/utils/constants/colors.dart';
// import 'package:clickcart/utils/constants/images.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class BannerSwiper extends StatefulWidget {

//   BannerSwiper({ super.key });

//   @override
//   State<BannerSwiper> createState() => _BannerSwiperState();
// }

// class _BannerSwiperState extends State<BannerSwiper> {



//   final List<Map<String, String>> images = [
//     {
//       'title': 'AirPods',
//       'sub-title': '2nd generation',
//       'price' : '\$1259.00',
//       'image': IKImages.offerEarbuds
//     },
//     {
//       'title': 'Shoes',
//       'sub-title': '1st generation',
//       'price' : '\$156.00',
//       'image': IKImages.offerShoes
//     },
//     {
//       'title': 'Bag',
//       'sub-title': '3nd generation',
//       'price' : '\$1139.00',
//       'image': IKImages.offerBag
//     },
//   ];

//   @override
//   Widget build(BuildContext context){
//     return Container(
//       constraints: const BoxConstraints(
//         minHeight: 174,
//         maxHeight: 300,
//       ),
//       height: MediaQuery.of(context).size.width / 2.2,
//       child: Swiper(
//         itemBuilder: (context, index) {

//           final catImage = images[index]['image']!;
//           final title = images[index]['title']!;
//           final subTitle = images[index]['sub-title']!;
//           final price = images[index]['price']!;
//           const image = IKImages.bannerBg;
//           return Stack(
//             children: [
//               Image.asset(
//                 image,
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.fill,
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       flex: 5,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(title,style: Theme.of(context).textTheme.headlineLarge?.merge(const TextStyle(color: Colors.white,fontSize: 35))),
//                             Text(subTitle,style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: IKColors.secondary))),
//                             const SizedBox(height: 6),
//                             Text(price,style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: Colors.white))),
//                             const SizedBox(height: 12),
//                             ElevatedButton(
//                               onPressed: (){
//                                 Navigator.pushNamed(context, '/products');
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                                 side: const BorderSide(color: Colors.white),
//                               ),
//                               child: const Text('Buy Now',style: TextStyle(fontSize: 14,color: IKColors.title)),
//                             ),
//                           ],
//                         ),
//                       )
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: Wrap(
//                         // mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(top: 10,left: 10),
//                             constraints: const BoxConstraints(
//                               maxHeight: 250,
//                             ),
//                             child: Image.asset(catImage,fit: BoxFit.contain)
//                           ),
//                         ]
//                       )
//                     ),
//                     const Spacer(flex: 1),
//                   ],
//                 ),
//               )
//             ],
//           );
//         },
//         indicatorLayout: PageIndicatorLayout.COLOR,

//         autoplay: true,
//         itemCount: images.length,
//         pagination: const SwiperPagination(
//           builder:DotSwiperPaginationBuilder(
//             size: 6,
//             activeSize: 8,
//             color: Color.fromARGB(60, 255, 255, 255),
//             activeColor: Colors.white,
//             space: 4,
//           )
//         )
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shimmer/shimmer.dart';

// class BannerSwiper extends StatefulWidget {
//   BannerSwiper({super.key});

//   @override
//   State<BannerSwiper> createState() => _BannerSwiperState();
// }

// class _BannerSwiperState extends State<BannerSwiper> {
//   List<Map<String, dynamic>> images = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchBannerData();
//   }

//   Future<void> fetchBannerData() async {
//     try {
//       final url = Uri.parse(
//           'https://backend.vansedemo.xyz/api/setting/store/customization/all');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final decodedResponse = json.decode(response.body);
//         print('Decoded response: $decodedResponse');

//         final Map<String, dynamic> data =
//             decodedResponse is List ? decodedResponse[0] : decodedResponse;

//         if (data.containsKey('slider')) {
//           final slider = data['slider'];

//           setState(() {
//             images = [
//               {
//                 'image': slider['first_img'],
//               },
//               {
//                 'image': slider['second_img'],
//               },
//               {
//                 'image': slider['third_img'],
//               },
//               {
//                 'image': slider['four_img'],
//               },
//               {
//                 'image': slider['five_img'],
//               },
//             ];
//           });
//         } else {
//           print('Slider data missing in response.');
//         }
//       } else {
//         print('Failed to load banners. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching banners: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // constraints: const BoxConstraints(
//       //   minHeight: 130,
//       //   maxHeight: 200,
//       // ),
//       // height: MediaQuery.of(context).size.width / 2.2,
//       height: 110,
//       child: images.isEmpty
//           ? Center(
//               child: Shimmer.fromColors(
//                 baseColor: Colors.grey[300]!,
//                 highlightColor: Colors.grey[100]!,
//                 child: Container(
//                   width: double.infinity,
//                   height: 110,
//                   color: Colors.white,
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                 ),
//               ),
//             )
//           : Swiper(
//               itemBuilder: (context, index) {
//                 final imageUrl = images[index]['image'];
//                 return Stack(
//                   children: [
//                     Positioned.fill(
//                       child: Image.network(
//                         imageUrl,
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) =>
//                             const Center(
//                                 child: Icon(Icons.broken_image, size: 50)),
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return const Center(
//                               child: SizedBox(
//                                 width: 25,
//                                 child: LoadingIndicator(indicatorType: Indicator.lineScalePulseOut),
//                               ));
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               autoplay: true,
//               itemCount: images.length,
//               pagination: const SwiperPagination(
//                 builder: DotSwiperPaginationBuilder(
//                   size: 6,
//                   activeSize: 8,
//                   color: Color.fromARGB(60, 255, 255, 255),
//                   activeColor: Colors.white,
//                   space: 4,
//                 ),
//               ),
//             ),
//     );
//   }
// }

class BannerSwiper extends StatefulWidget {
  BannerSwiper({super.key});

  @override
  State<BannerSwiper> createState() => _BannerSwiperState();
}

class _BannerSwiperState extends State<BannerSwiper> {
  List<Map<String, dynamic>> images = [];

  @override
  void initState() {
    super.initState();
    fetchBannerData();
  }

  Future<void> fetchBannerData() async {
    try {
      final url = Uri.parse(
          'https://backend.vansedemo.xyz/api/setting/store/customization/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        // print('Decoded response: $decodedResponse');

        final Map<String, dynamic> data =
            decodedResponse is List ? decodedResponse[0] : decodedResponse;

        if (data.containsKey('slider')) {
          final slider = data['slider'];

          setState(() {
            images = [
              {'image': slider['first_img']},
              {'image': slider['second_img']},
              {'image': slider['third_img']},
              {'image': slider['four_img']},
              {'image': slider['five_img']},
            ];
          });
        } else {
          print('Slider data missing in response.');
        }
      } else {
        print('Failed to load banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching banners: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      child: images.isEmpty
          ? Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            )
          : Swiper(
              itemBuilder: (context, index) {
                final imageUrl = images[index]['image'];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 130,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 25,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOut,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              autoplay: true,
              itemCount: images.length,
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  size: 6,
                  activeSize: 8,
                  color: Color.fromARGB(60, 255, 255, 255),
                  activeColor: Colors.white,
                  space: 4,
                ),
              ),
            ),
    );
  }
}
