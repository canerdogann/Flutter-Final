import 'package:flutter_advanced_dev/categories.dart/automotive.dart';
import 'package:flutter_advanced_dev/categories.dart/book.dart';
import 'package:flutter_advanced_dev/categories.dart/cosmetics.dart';
import 'package:flutter_advanced_dev/categories.dart/electronics.dart';
import 'package:flutter_advanced_dev/categories.dart/fashion.dart';
import 'package:flutter_advanced_dev/categories.dart/gaming.dart';
import 'package:flutter_advanced_dev/categories.dart/grocery.dart';
import 'package:flutter_advanced_dev/categories.dart/music.dart';
import 'package:flutter_advanced_dev/categories.dart/sports.dart';
import 'package:go_router/go_router.dart';

import '../screens/client/register.dart';
import '../screens/client/login.dart';
import '../screens/client/profile.dart';
import '../screens/core/error.dart';
import '../screens/core/loader.dart';
import '../screens/core/settings.dart';
import '../screens/home.dart';
import '../screens/payment/payment.dart';
import '../screens/product/cart.dart';
import '../screens/product/favorites.dart';
import '../screens/product/product.dart';
import '../screens/product/products.dart';
import '../screens/static/about.dart';
import '../screens/static/boarding.dart';
import '../screens/static/contact.dart';

final routes = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoaderScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/product/:productId',
      builder: (context, state) {
        final productId = state.pathParameters['productId'];
        return ProductScreen(
          product: getProductById(productId),
        );
      },
    ),
    GoRoute(
      path: "/automotive",
      builder: (context, state) => const Automotive(),
    ),
    GoRoute(
      path: "/book",
      builder: (context, state) => const Book(),
    ),
    GoRoute(
      path: "/cosmetics",
      builder: (context, state) => const Cosmetic(),
    ),
    GoRoute(
      path: "/gaming",
      builder: (context, state) => const Gaming(),
    ),
     GoRoute(
      path: "/electronics",
      builder: (context, state) => const Electronics(),
    ),
     GoRoute(
      path: "/garden",
      builder: (context, state) => const Grocery(),
    ),
     GoRoute(
      path: "/fashion",
      builder: (context, state) => const Fashion(),
    ),
     GoRoute(
      path: "/music",
      builder: (context, state) => const Music(),
    ),
     GoRoute(
      path: "/sports",
      builder: (context, state) => const Sports(),
    ),
    GoRoute(
      path: "/products",
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: "/favorites",
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: "/cart",
      builder: (context, state) => const CartScreen(),
    ),
  ],
);
