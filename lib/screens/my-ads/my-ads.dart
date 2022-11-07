import 'package:blog/model/post.dart';
import 'package:blog/screens/home/post-card.dart';
import 'package:blog/services/post.dart';
import 'package:flutter/material.dart';

class MyAdsScreen extends StatelessWidget {
  const MyAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: PostService().fetchMyPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PostModel> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: ((context, index) {
                return PostCard(
                  title: posts[index].title!,
                  description: posts[index].description!,
                );
              }),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
