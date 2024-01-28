import 'package:design_patterns/patterns/fly_weight/fly_weight_factory.dart';
import 'package:design_patterns/patterns/fly_weight/model/social_media_post.dart';
import 'package:flutter/material.dart';

final class FlyWeightView extends StatelessWidget {
  final IconFactory iconFactory = IconFactory();

  FlyWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                final post = SocialMediaPost(
                  title: 'Post $index',
                  content:
                      '-$index Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                );

                return ListTile(
                  leading: iconFactory
                      .getIcon(iconData: Icons.account_circle)
                      .createWidget(Colors.blue, 24.0),
                  title: Text(post.title),
                  subtitle: Text(post.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      iconFactory
                          .getIcon(iconData: Icons.comment)
                          .createWidget(Colors.grey, 20.0),
                      const SizedBox(width: 8),
                      iconFactory
                          .getIcon(iconData: Icons.thumb_up)
                          .createWidget(Colors.grey, 20.0),
                      const SizedBox(width: 8),
                      iconFactory
                          .getIcon(iconData: Icons.share)
                          .createWidget(Colors.grey, 20.0),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
