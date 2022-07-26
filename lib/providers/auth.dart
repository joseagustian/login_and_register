import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCK3qYTt--QZ2IQhpgMrPVROSiHCiFYt1U");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
          "displayName": "$firstName $lastName"
        }),
      );

      var responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw responseData["error"]["message"];
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCK3qYTt--QZ2IQhpgMrPVROSiHCiFYt1U");

    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
          }));

      var responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        throw responseData["error"]["message"];
      }
    } catch (error) {
      rethrow;
    }
  }
}
