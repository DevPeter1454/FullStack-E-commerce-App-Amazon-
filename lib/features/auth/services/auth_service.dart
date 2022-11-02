import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_nav.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variables.dart';

class AuthService {
  //sign up user
  void signUpUser({
    required email,
    required password,
    required name,
    required context,
  }) async {
    print('signing up user');
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []
          );
      http.Response res = await http.post(Uri.parse('$uri/auth/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Account created successfully. Login with the same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    
  }

  void signInUser({
    required email,
    required password,
    required context,
  }) async {
    print('signing in user');
    try {
      http.Response res = await http.post(Uri.parse('$uri/auth/api/login'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
      print(res.body);
      // print(res.statusCode);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    // print('getting data');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token!.isEmpty) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/auth/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      });

      var response = jsonDecode(tokenRes.body);
     
      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('$uri/auth/getdata'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
            // userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      print('${e.toString()} here');
    }
  }
}
