import 'dart:convert';

class PostAPI1 {
  String getYoutubePosts() {
    return '''
    [
      {
        "title": "Automatic code generation with Fluuter",
        "description": "Generate automatically"
      },
      {
        "title": "Twitter Clone code generation with Fluuter",
        "description": "Generate automatically"
      }
    ]
    ''';
  }
}

class PostAPI2 {
  String getMediumPosts() {
    return '''
    [
      {
        "header": "Medium header1",
        "bio": "Medium bio1"
      },
      {
        "header": "Medium header2",
        "bio": "Medium bio2"
      }
    ]
    ''';
  }
}

abstract class IPostAPI {
  List<Post> getPosts();
}

final class Post {
  final String title;
  final String bio;

  Post({
    required this.title,
    required this.bio,
  });
}

class PostAPI1Adapter implements IPostAPI {
  final _api = PostAPI1();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(_api.getYoutubePosts()) as List;

    return data
        .map(
          (e) => Post(
            title: e["title"],
            bio: e["description"],
          ),
        )
        .toList();
  }
}

class PostAPI2Adapter implements IPostAPI {
  final _api = PostAPI2();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(_api.getMediumPosts()) as List;

    return data
        .map(
          (e) => Post(
            title: e["header"],
            bio: e["bio"],
          ),
        )
        .toList();
  }
}

class PostAPI implements IPostAPI {
  final firstAPI = PostAPI1Adapter();
  final secondAPI = PostAPI2Adapter();
  @override
  List<Post> getPosts() {
    return firstAPI.getPosts() + secondAPI.getPosts();
  }
}
