// import 'package:clickcart/components/bottomsheet/notification_sheet.dart';
import 'dart:convert';
import 'package:clickcart/components/drawer/drawer_menu.dart';
import 'package:clickcart/components/list/list_item.dart';
import 'package:clickcart/screens/profile/privacy_policy.dart';
import 'package:clickcart/screens/profile/terms_conditions.dart';
import 'package:clickcart/utils/constants/colors.dart';
// import 'package:clickcart/utils/constants/colors.dart';
// import 'package:clickcart/utils/constants/images.dart';
import 'package:clickcart/utils/constants/sizes.dart';
import 'package:clickcart/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';
  String mobile = '';
  String address = '';
  String username = '';
  String userEmail = '';
  bool isLoading = true;
  final String hiveBoxName = 'userBox';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchLogindetails();
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse(
          'https://backend.vansedemo.xyz/api/setting/store/customization/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        // print('Decoded response: $decodedResponse');

        final Map<String, dynamic> data =
            decodedResponse is List ? decodedResponse[0] : decodedResponse;

        if (data.containsKey('footer')) {
          final aboutus = data['footer'];

          setState(() {
            address = aboutus['block4_address']['en'] ?? 'Address';
            mobile = aboutus['block4_phone'] ?? '1234567890';
            email = aboutus['block4_email'] ?? 'zoroz@123';
            isLoading = false;
          });
        } else {
          print('Contact data missing in response.');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching contact details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchLogindetails() async {
    var box = await Hive.openBox('userBox');
    final loginData = box.get('loginData');

    if (loginData != null) {
      print('Phone: ${loginData['phone']}');
      print('Token (if available): ${loginData['token']}');
      print('Name : ${loginData['name']}');
      print('Email : ${loginData['email']}');
      print('Id : ${loginData['_id']}');
      setState(() {
        userEmail = loginData['email'];
        username = loginData['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(IKSizes.container, IKSizes.headerHeight),
          child: Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(maxWidth: IKSizes.container),
              child: AppBar(
                title: Image.asset(
                  'assets/images/applogo.png',
                  height: 30,
                ),
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
                ],
              ),
            ),
          )),
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
                // Container(
                //   margin: const EdgeInsets.only(bottom: 10),
                //     padding: const EdgeInsets.all(15),
                //   color: Theme.of(context).cardColor,
                //   child: ListTile(
                //     leading: Icon(Icons.account_circle, size: 60,color: Colors.blueGrey[300],),
                //     title: Text(username,
                //           style: Theme.of(context)
                //               .textTheme
                //               .headlineLarge
                //               ?.merge(const TextStyle(
                //                   fontWeight: FontWeight.w400))),
                //                   subtitle: Text(userEmail,
                //           style: const TextStyle(
                //                   fontWeight: FontWeight.w400, color: IKColors.primary , fontSize: 16)),
                //   ),
                // ),
                // Container(
                //     margin: const EdgeInsets.only(bottom: 10),
                //     padding: const EdgeInsets.all(15),
                //     color: Theme.of(context).cardColor,
                //     child: Column(children: [
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(20),
                //         child: Icon(Icons.account_circle, size: 80,color: Colors.blueGrey[300],)
                //         // Image.asset(IKImages.profile,
                //         //     height: 80, width: 80),
                //       ),
                //       // const SizedBox(height: 15),
                //       Text(username,
                //           style: Theme.of(context)
                //               .textTheme
                //               .headlineLarge
                //               ?.merge(const TextStyle(
                //                   fontWeight: FontWeight.w400))),
                //       Text(userEmail,
                //           style: const TextStyle(
                //                   fontWeight: FontWeight.w400, color: IKColors.primary , fontSize: 12)),
                //     ])),
                // Text(),
                isLoading
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Theme.of(context).cardColor,
                        child: const Column(
                          children: [
                            Text('Fetching user details'),
                            SizedBox(
                                width: 20,
                                child: LoadingIndicator(
                                    indicatorType: Indicator.lineScalePulseOut))
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Theme.of(context).cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: Text('User Profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            Container(
                              color: Theme.of(context).cardColor,
                              child: ListTile(
                                leading: Icon(
                                  Icons.account_circle,
                                  size: 60,
                                  color: Colors.blueGrey[300],
                                ),
                                title: Text(username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.merge(const TextStyle(
                                            fontWeight: FontWeight.w400))),
                                subtitle: Text(userEmail,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: IKColors.primary,
                                        fontSize: 16)),
                              ),
                            ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor))),
                        child: Text('Account Settings',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            // ListItem(
                            //   onTap: () {
                            //     Navigator.pushNamed(context, '/edit_profile');
                            //   },
                            //   icon: SvgPicture.string(
                            //     IKSvg.profile,
                            //     width: 20,
                            //     height: 20,
                            //   ),
                            //   title: "Edit profile",
                            // ),
                            ListItem(
                              onTap: () {
                                Navigator.pushNamed(context, '/my_orders');
                              },
                              icon: SvgPicture.string(
                                IKSvg.address,
                                width: 20,
                                height: 20,
                              ),
                              title: "My Orders",
                            ),
                            ListItem(
                              onTap: () {
                                var paymentBox = Hive.box('paymentBox');
                                paymentBox.clear();
                                var deliveryBox = Hive.box('deliveryBox');
                                deliveryBox.clear();
                                var userBox = Hive.box('userBox');
                                userBox.clear();

                                Navigator.pushNamed(context, '/signin');
                              },
                              icon: SvgPicture.string(
                                IKSvg.signout,
                                width: 20,
                                height: 20,
                              ),
                              title: "Logout",
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor))),
                        child: Text('Support Center',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            ListItem(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PrivacyPolicy(),
                                  ),
                                );
                              },
                              icon: SvgPicture.string(
                                IKSvg.list,
                                width: 20,
                                height: 20,
                              ),
                              title: "Privacy Policy",
                            ),
                            ListItem(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsConditions(),
                                  ),
                                );
                              },
                              icon: SvgPicture.string(
                                IKSvg.receipt,
                                width: 20,
                                height: 20,
                              ),
                              title: "Terms & Conditions",
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor))),
                        child: Text('About Us',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.apartment, size: 15),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Text(
                                      address,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.call, size: 15),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text('Tel : $mobile',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.mail, size: 15),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text('Email : $email',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ],
                          ))
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
