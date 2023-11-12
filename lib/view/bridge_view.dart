import 'package:design_patterns/patterns/bridge/bridge.dart';
import 'package:flutter/material.dart';

class BridgeView extends StatefulWidget {
  const BridgeView({super.key});

  @override
  State<BridgeView> createState() => _BridgeViewState();
}

class _BridgeViewState extends State<BridgeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bridge Design Pattern"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Video youtubeVideo = YoutubeVideo(processor: HDProcessor());
                youtubeVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as HD Quality in Youtube";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a HD Video in Youtube"),
            ),
            OutlinedButton(
              onPressed: () {
                Video netflixVideo = NetflixVideo(processor: UHD4KProcessor());
                netflixVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as UHD 4K Quality in Netflix";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a UHD 4K Video in Netflix"),
            ),
            OutlinedButton(
              onPressed: () {
                Video amazonPrimeVideo = AmazonPrimeVideo(processor: QUHD8KProcessor());
                amazonPrimeVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as QUHD 8K Quality in Amazon Prime";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a QUHD 8K Video in Amazon Prime"),
            ),
          ],
        ),
      ),
    );
  }
}
