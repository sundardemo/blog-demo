import 'dart:convert';

import 'package:blog/model/ad.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyAdsListingScreen extends StatelessWidget {
  const MyAdsListingScreen({super.key});

  Future<List<AdModel>> makeRequest() async {
    List<AdModel> ads = [];
    try {
      var resp =
          await http.get(Uri.parse('https://adlisting.herokuapp.com/ads'));
      var respJson = jsonDecode(resp.body);
      var adsData = respJson['data'];
      ads = adsData.map<AdModel>((ad) => AdModel.fromJson(ad)).toList();
      print(ads);
      return ads;
    } catch (e) {
      print(e);
      return ads;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyAdsListing"),
      ),
      body: FutureBuilder(
        future: makeRequest(),
        builder: ((context, snapshot) {
          print(snapshot.data);
          List<AdModel> ads = snapshot.data!;
          return ListView.builder(
            itemCount: ads.length,
            itemBuilder: ((context, index) {
              return Text(
                  ads[index].images!.isEmpty ? '' : ads[index].images![0]);
              //return Text(ads[index].images![0]);
            }),
          );
        }),
      ),
    );
  }
}
