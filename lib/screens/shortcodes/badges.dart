import 'package:clickcart/components/badge/badge_light.dart';
import 'package:clickcart/components/badge/custom_badge.dart';
import 'package:clickcart/components/badge/outline_badge.dart';
import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Badges extends StatelessWidget {
  const Badges({ super.key });

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
              title: const Text('Badges'),
              titleSpacing: 5,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(IKSizes.borderRadiusSm)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Text('Classic Badge',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                title:'Primary'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                textColor : Colors.black,
                                backgroundColor : IKColors.secondary,
                                title:'Secondary'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                backgroundColor : IKColors.danger,
                                title:'Danger'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                backgroundColor : IKColors.success,
                                title:'Success'
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(IKSizes.borderRadiusSm)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Text('Light Badge',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: BadgeLight(
                                title:'Primary',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: BadgeLight(
                                textColor : Colors.black,
                                color : IKColors.secondary,
                                title:'Secondary'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: BadgeLight(
                                color : IKColors.danger,
                                title:'Danger',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: BadgeLight(
                                color : IKColors.success,
                                title:'Success'
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(IKSizes.borderRadiusSm)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Text('Badge Outline',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: OutlineBadge(
                                title:'Primary',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: OutlineBadge(
                                textColor : Color.fromARGB(255, 175, 139, 24),
                                color : IKColors.secondary,
                                title:'Secondary'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: OutlineBadge(
                                color : IKColors.danger,
                                title:'Danger',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: OutlineBadge(
                                color : IKColors.success,
                                title:'Success'
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(IKSizes.borderRadiusSm)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Text('Rounded Badge',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                title:'Primary',
                                rounded: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                textColor : Colors.black,
                                backgroundColor : IKColors.secondary,
                                rounded: true,
                                title:'Secondary'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                backgroundColor : IKColors.danger,
                                rounded: true,
                                title:'Danger'
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                backgroundColor : IKColors.success,
                                rounded: true,
                                title:'Success'
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(IKSizes.borderRadiusSm)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                        child: Text('Size Badge',style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                title:'Small',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                title:'Medium',
                                size: 'md',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0,bottom: 8.0),
                              child: CustomBadge(
                                title:'Large',
                                size: 'lg',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}