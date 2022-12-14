import 'dart:convert';

import 'package:blog/model/user.dart';
import 'package:blog/utils/alert_manager.dart';
import 'package:blog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  void register(UserModel user) async {
    var url = Uri.parse("${Constants().serverUrl}/auth/register");
    print(url);
    var userObj = user.toJson();
    try {
      var resp = await http.post(url, body: jsonEncode(userObj), headers: {
        'Content-Type': 'application/json',
      });
      print(resp.body);
    } catch (e) {
      print(e);
    }
  }

  void login(context, UserModel user) async {
    var storage = FlutterSecureStorage();
    var url = Uri.parse("${Constants().serverUrl}/auth/login");
    print(url);
    var userObj = user.toJson();
    try {
      var resp = await http.post(url, body: jsonEncode(userObj), headers: {
        'Content-Type': 'application/json',
      });
      var respObj = jsonDecode(resp.body);
      print(respObj);
      if (respObj['status'] == false) {
        AlertManager().displaySnackbar(context, respObj['message']);
      }
      if (respObj['status'] == true) {
        storage.write(key: 'userId', value: respObj['data']['user']['_id']);
        storage.write(key: 'token', value: respObj['data']['token']);
        storage.write(
            key: 'refreshToken', value: respObj['data']['refreshToken']);
        Navigator.pushNamed(context, '/');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> refreshToken() async {
    var storage = FlutterSecureStorage();
    var userId = await storage.read(key: 'userId');
    var refreshToken = await storage.read(key: 'refreshToken');
    var url = Uri.parse("${Constants().serverUrl}/auth/refreshToken");
    if (refreshToken != null) {
      var resp = await http.post(url,
          body: jsonEncode(
            {
              "id": userId,
              "refreshToken": refreshToken,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
          });
      var respObj = jsonDecode(resp.body);
      if (respObj['status'] == true) {
        storage.write(key: 'token', value: respObj['data']['token']);
        storage.write(
            key: 'refreshToken', value: respObj['data']['refreshToken']);
      }
      return true;
    } else {
      //Navigator.pushReplacementNamed(context, '/');
      print("");
      return false;
    }
  }
}
