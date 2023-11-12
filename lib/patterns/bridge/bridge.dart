// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

abstract class VideoProcessor {
  void process({required String videoFile});
}

interface class Video {
  VideoProcessor processor;

  Video({required this.processor});

  void play({required String videoFile}) {}
}

class NetflixVideo implements Video {
  @override
  VideoProcessor processor;

  NetflixVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class YoutubeVideo implements Video {
  @override
  VideoProcessor processor;

  YoutubeVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class AmazonPrimeVideo implements Video {
  @override
  VideoProcessor processor;

  AmazonPrimeVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class HDProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing HD Processor");
  }
}

class UHD4KProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing UHD 4K Processor");
  }
}

class QUHD8KProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing UHD 8K Processor");
  }
}
