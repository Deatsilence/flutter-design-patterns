import 'package:design_patterns/patterns/fecade/model/news.dart';

final class NewsService {
  Future<List<News>> getLatestNews() {
    return Future.value(
      List.generate(
        10,
        (index) => News(),
      ),
    );
  }
}
