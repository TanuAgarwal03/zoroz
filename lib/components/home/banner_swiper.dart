import 'package:card_swiper/card_swiper.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:flutter/material.dart';

class BannerSwiper extends StatelessWidget {

  BannerSwiper({ super.key });

  final List<Map<String, String>> images = [
    {'title': 'Mobiles', 'image': IKImages.cat1},
    {'title': 'Electronics', 'image': IKImages.cat1},
    {'title': 'Camera', 'image': IKImages.cat1},
  ];

  @override
  Widget build(BuildContext context){
    return Container(
      constraints: const BoxConstraints(
        minHeight: 174,
        maxHeight: 350,
      ),
      height: MediaQuery.of(context).size.width / 2.2,
      child: Swiper(
        itemBuilder: (context, index) {
          // final image = images[index];
          const image = IKImages.bannerBg;
          return Stack(
            children: [
              Image.asset(
                image,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('AirPods',style: Theme.of(context).textTheme.headlineLarge?.merge(const TextStyle(color: Colors.white,fontSize: 35))),
                            Text('2nd generation',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: IKColors.secondary))),
                            const SizedBox(height: 6),
                            Text('\$1259.00*',style: Theme.of(context).textTheme.titleLarge?.merge(const TextStyle(color: Colors.white))),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                side: const BorderSide(color: Colors.white),  
                              ), 
                              child: const Text('Buy Now',style: TextStyle(fontSize: 14,color: IKColors.title)),
                            ),
                          ],
                        ),
                      )
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10,left: 10),
                            constraints: const BoxConstraints(
                              maxHeight: 250,
                            ),
                            child: Image.asset(IKImages.offerEarbuds,fit: BoxFit.contain)
                          ),
                        ]
                      )
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              )
            ],
          );
        },
        // indicatorLayout: PageIndicatorLayout.COLOR,
        
        autoplay: true,
        itemCount: images.length,
        pagination: const SwiperPagination(
          builder:DotSwiperPaginationBuilder(
            size: 6,
            activeSize: 8,
            color: Color.fromARGB(60, 255, 255, 255),
            activeColor: Colors.white,
            space: 4,
          )
        )
      ),
    );
  }
}