import 'package:amazon_clone/common/widgets/bottom_nav.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/home/search/screens/search_screen.dart';
import 'package:amazon_clone/features/product_details/screens/screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen());
      case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen());
      case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar());
      case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen());
      case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  AddressScreen(
          totalAmount: totalAmount,
        ));
      case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ));
      case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  CategoryDealsScreen(
          category: category,
        ));
        case ProductDeals.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDeals(
          product:product,
        ));
    default: 
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_)=>const Scaffold(body: Center(child: Text('Screen does not exist')),));
  }
}
