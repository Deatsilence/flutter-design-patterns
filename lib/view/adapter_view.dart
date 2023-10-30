import 'package:design_patterns/patterns/adapter/adapter.dart';
import 'package:flutter/material.dart';

class AdapterView extends StatelessWidget {
  const AdapterView({super.key});

  @override
  Widget build(BuildContext context) {
    final postAPI = PostAPI();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: postAPI.getPosts().length,
                itemBuilder: (BuildContext context, int index) {
                  final post = postAPI.getPosts()[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.bio),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
