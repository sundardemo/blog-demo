import 'package:blog/model/post.dart';
import 'package:blog/services/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create a post')),
      body: Column(children: [
        TextField(
          controller: _titleCtrl,
        ),
        TextField(
          controller: _descCtrl,
        ),
        TextButton(
            onPressed: () {
              var post = PostModel(
                title: _titleCtrl.text,
                description: _descCtrl.text,
              );
              PostService().createPost(post);
            },
            child: Text("Create a Post"))
      ]),
    );
  }
}
