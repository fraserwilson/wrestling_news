import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_news/models/news_article_model.dart';
import 'package:wrestling_news/services/news_stories_service.dart';

part 'news_article_state.dart';

class NewsArticleCubit extends Cubit<NewsArticleState> {
  NewsArticleCubit() : super(const NewsArticleInitial());

  Future<void> fetchNewsStories() async {
    try {
      emit(NewsArticleLoading(state.mainNewsArticleState));
      NewsStoriesService newsStoriesService = NewsStoriesService();
      final response = await newsStoriesService.fetchWrestlingNewsStories();

      emit(
        NewsArticleLoaded(state.mainNewsArticleState),
      );
    } catch (e) {
      emit(NewsArticleError(
          state.mainNewsArticleState, 'Failed to fetch news stories: $e'));
    }
  }
}
