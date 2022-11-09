import 'dart:convert';

import 'package:blog/model/post.dart';
import 'package:blog/services/auth.dart';
import 'package:blog/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<PostModel>> fetchAllPosts() async {
    List<PostModel> posts = [];
    var url = Uri.parse("${Constants().serverUrl}/posts");
    try {
      var resp = await http.get(url);

      var respJson = jsonDecode(resp.body);
      var postData = respJson['data'];
      posts =
          postData.map<PostModel>((post) => PostModel.fromJson(post)).toList();

      return posts;
    } catch (e) {
      print(e.toString());
      return posts;
    }
  }

  Future<List<PostModel>> fetchMyPosts() async {
    var storage = FlutterSecureStorage();
    List<PostModel> posts = [];
    var url = Uri.parse("${Constants().serverUrl}/posts/me");
    var token = await storage.read(key: 'token');
    print(token);
    // try {
    var resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(resp.statusCode);
    if (resp.statusCode == 401) {
      var isNewTokenGenerated = await AuthService().refreshToken();
      if (isNewTokenGenerated) {
        fetchMyPosts();
      }
    }
    print(resp.body);
    var respJson = jsonDecode(resp.body);

    var postData = respJson['data'];
    posts =
        postData.map<PostModel>((post) => PostModel.fromJson(post)).toList();

    return posts;
    // } catch (e) {
    //   print(e.toString());
    //   return posts;
    // }
  }
}
