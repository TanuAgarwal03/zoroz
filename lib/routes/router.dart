import 'package:clickcart/screens/cart/cart.dart';
import 'package:clickcart/screens/category/category.dart';
import 'package:clickcart/screens/chat/chat_list.dart';
import 'package:clickcart/screens/chat/chat_screen.dart';
import 'package:clickcart/screens/notifications/notifications.dart';
import 'package:clickcart/screens/order/my_orders.dart';
import 'package:clickcart/screens/order/track_order.dart';
import 'package:clickcart/screens/order/write_review.dart';
import 'package:clickcart/screens/payment/add_card.dart';
import 'package:clickcart/screens/payment/add_delivery_address.dart';
import 'package:clickcart/screens/payment/checkout.dart';
import 'package:clickcart/screens/payment/payment.dart';
import 'package:clickcart/screens/product/product_detail.dart';
import 'package:clickcart/screens/product/products.dart';
import 'package:clickcart/screens/profile/coupons.dart';
import 'package:clickcart/screens/profile/edit_profile.dart';
import 'package:clickcart/screens/profile/profile.dart';
import 'package:clickcart/screens/profile/questions.dart';
import 'package:clickcart/screens/search/search_screen.dart';
import 'package:clickcart/screens/shortcodes/accordion.dart';
import 'package:clickcart/screens/shortcodes/badges.dart';
import 'package:clickcart/screens/shortcodes/bottomsheet.dart';
import 'package:clickcart/screens/shortcodes/buttons.dart';
import 'package:clickcart/screens/shortcodes/charts.dart';
import 'package:clickcart/screens/shortcodes/components.dart';
import 'package:clickcart/screens/shortcodes/inputs.dart';
import 'package:clickcart/screens/shortcodes/lists.dart';
import 'package:clickcart/screens/shortcodes/modalbox.dart';
import 'package:clickcart/screens/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:clickcart/screens/auth/choose_language.dart';
import 'package:clickcart/screens/auth/sign_in.dart';
import 'package:clickcart/screens/auth/otp.dart';
import 'package:clickcart/screens/auth/sign_up.dart';
import 'package:clickcart/routes/bottom_navigation/bottom_navigation.dart';
import 'package:clickcart/screens/payment/delivery_address.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/choose_language': (context) => const ChooseLanguage(),
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
    '/product_detail': (context) => const ProductDetail(),
    '/edit_profile': (context) => const EditProfile(),
    '/search_screen': (context) => SearchScreen(),
    '/chat_list': (context) => ChatList(),
    '/chat_screen': (context) => ChatScreen(),
    '/my_orders': (context) => const MyOrders(),
    '/track_order': (context) => const TrackOrder(),
    '/write_review': (context) => const WriteReview(),
    '/cart': (context) => Cart(),
    '/wishlist': (context) => Wishlist(),
    '/notifications': (context) => Notifications(),
    '/coupons': (context) => Coupons(),
    '/profile': (context) => const Profile(),
    '/categories': (context) => Category(),
    '/questions': (context) => Questions(),
    '/components': (context) => const Components(),
    '/accordion': (context) =>  AccordionScreen(),
    '/bottomsheet': (context) =>  const Bottomsheet(),
    '/modalbox': (context) =>  const ModalBox(),
    '/buttons': (context) =>  const Buttons(),
    '/badges': (context) =>  const Badges(),
    '/charts': (context) =>  const Charts(),
    '/inputs': (context) =>  const Inputs(),
    '/lists': (context) =>  const Lists(),
  };
}