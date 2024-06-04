import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/providers/user_provider.dart';
import 'package:flutter_auth/screens/home_screen.dart';
import 'package:flutter_auth/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../utils/constants.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user =
          User(id: '', name: name, email: email, password: password, token: '');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Account Created! Login to Continue");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signIn'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      if (token == null) {
        pref.setString('x-auth-String', '');
      }
      var tokenRes = await http.post(Uri.parse('${Constants.uri}/tokenIsValid'),
          headers: <String, String>{
            'content-type': "application/json; charset=UTF-8",
            'x-auth-token': token!,
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response res =
            await http.get(Uri.parse(Constants.uri), headers: <String, String>{
          'content-type': "application/json; charset=UTF-8",
          'x-auth-token': token,
        });
        userProvider.setUser(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
