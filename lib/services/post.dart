import 'dart:convert';

import 'package:blog/model/post.dart';
import 'package:blog/services/apiprovider.dart';
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
    List<PostModel> posts = [];

    var resp = await ApiProvider().post('/posts/me', {});
    var postData = resp['data'];
    posts =
        postData.map<PostModel>((post) => PostModel.fromJson(post)).toList();

    return posts;
  }
}
