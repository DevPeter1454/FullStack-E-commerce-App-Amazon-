import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProduct(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/products/get-category-products?category=$category'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          
          );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                  Product.fromJson(jsonEncode(jsonDecode(response.body)[i])));
            }
            print('just done');
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
    return productList;
  }
   Future<Product> fetchDealOfTheDay(
      {required BuildContext context, }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(category: '', name: '', description: '', price: 0, quantity: 0 , images: [], );
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/products/deal-of-the-day'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          
          );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            product = Product.fromJson(response.body);
            print('just done');
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
