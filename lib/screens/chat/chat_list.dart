import 'package:clickcart/utils/constants/colors.dart';
import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatList extends StatelessWidget {
  ChatList({ super.key });

  final List<Map<String, String>> chatList = [
    {
      'image' : IKImages.chatUser1,
      'name' : 'Emily Johnson',
      'last_message' : 'Text me!',
      'last_date' : 'Fri',
    },
    {
      'image' : IKImages.chatUser2,
      'name' : 'Michael Anderson',
      'last_message' : 'Call me back.',
      'last_date' : 'Mon',
    },
    {
      'image' : IKImages.chatUser3,
      'name' : 'Olivia Davis',
      'last_message' : 'I got you bro!',
      'last_date' : '2 Hours',
    },
    {
      'image' : IKImages.chatUser4,
      'name' : 'Daniel Wilson',
      'last_message' : 'Haha, i hit you up',
      'last_date' : '2 Min',
    },
    {
      'image' : IKImages.chatUser5,
      'name' : 'Sophia Martinez',
      'last_message' : 'Call me back.',
      'last_date' : 'Sun',
    },
    {
      'image' : IKImages.chatUser6,
      'name' : 'William Thompson',
      'last_message' : 'Haha, i hit you up',
      'last_date' : '7 Aug 2023',
    },
    {
      'image' : IKImages.chatUser1,
      'name' : 'Ava Hernandez',
      'last_message' : 'Text me!',
      'last_date' : 'Tus',
    },
    {
      'image' : IKImages.chatUser2,
      'name' : 'James White',
      'last_message' : 'I got you bro!',
      'last_date' : 'Fri',
    },
    {
      'image' : IKImages.chatUser3,
      'name' : 'Mia Rodriguez',
      'last_message' : 'Call me back.',
      'last_date' : 'Mon',
    },
    {
      'image' : IKImages.chatUser4,
      'name' : 'Benjamin Clark',
      'last_message' : 'Text me!',
      'last_date' : '2 Hours',
    },
    {
      'image' : IKImages.chatUser5,
      'name' : 'Emily Johnson',
      'last_message' : 'Text me!',
      'last_date' : 'Fri',
    },
    {
      'image' : IKImages.chatUser6,
      'name' : 'Michael Anderson',
      'last_message' : 'Text me!',
      'last_date' : 'Fri',
    },
    {
      'image' : IKImages.chatUser1,
      'name' : 'Olivia Davis',
      'last_message' : 'Text me!',
      'last_date' : 'Fri',
    },
  ];

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
              title: const Text('Messages'),
              titleSpacing: 5,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search_screen');
                  }, 
                  iconSize: 28,
                  icon: SvgPicture.string(IKSvg.search),
                ),
              ]
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: chatList.map((item){
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chat_screen');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(bottom: BorderSide(width: 1,color: Theme.of(context).dividerColor))
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(item['image']!,height: 50,width: 50),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                  color: IKColors.success,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(width: 2,color: Theme.of(context).cardColor),
                                ),
                              )
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(item['name']!,style: Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 5),
                              Text(item['last_message']!,style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        Text(item['last_date']!,style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}