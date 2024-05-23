import 'package:clickcart/screens/chat/chat_list.dart';
import 'package:clickcart/screens/chat/chat_screen.dart';
import 'package:clickcart/screens/payment/add_card.dart';
import 'package:clickcart/screens/payment/add_delivery_address.dart';
import 'package:clickcart/screens/payment/checkout.dart';
import 'package:clickcart/screens/payment/payment.dart';
import 'package:clickcart/screens/product/product_detail.dart';
import 'package:clickcart/screens/product/products.dart';
import 'package:clickcart/screens/profile/edit_profile.dart';
import 'package:clickcart/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/screens/auth/choose_language.dart';
import 'package:clickcart/screens/auth/sign_in.dart';
import 'package:clickcart/screens/auth/otp.dart';
import 'package:clickcart/screens/auth/sign_up.dart';
import 'package:clickcart/routes/bottom_navigation/bottom_navigation.dart';
import 'package:clickcart/screens/payment/delivery_address.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const ChooseLanguage(),
    '/signin': (context) => const SignIn(),
    '/otp': (context) => const Otp(),
    '/signup': (context) => const SignUp(),
    '/main_home': (context) => const BottomNavigation(),
    '/delivery_address': (context) => const DeliveryAddress(),
    '/add_delivery_address': (context) => const AddDeliveryAddress(),
    '/payment': (context) => const Payment(),
    '/add_card': (context) => const AddCard(),
    '/checkout': (context) => const Checkout(),
    '/products': (context) => const Products(),
    '/products_detal': (context) => ProductDetail(),
    '/edit_profile': (context) => EditProfile(),
    '/search_screen': (context) => SearchScreen(),
    '/chat_list': (context) => ChatList(),
    '/chat_screen': (context) => ChatScreen(),
  };
}