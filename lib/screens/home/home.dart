import 'package:blog/model/post.dart';
import 'package:blog/screens/home/post-card.dart';
import 'package:blog/services/post.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/my-ads');
              },
              icon: Icon(Icons.account_circle_outlined))
        ],
      ),
      body: FutureBuilder(
        future: PostService().fetchAllPosts(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-post');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
