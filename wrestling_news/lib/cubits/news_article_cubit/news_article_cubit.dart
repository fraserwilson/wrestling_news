import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_news/models/news_article_model.dart';

part 'news_article_state.dart';

class NewsArticleCubit extends Cubit<NewsArticleState> {
  NewsArticleCubit() : super(const NewsArticleInitial());

  // Fetch data from Firestore
  Future<void> fetchNewsStories() async {
    try {
      emit(NewsArticleLoading(state.mainNewsArticleState));
      final QuerySnapshot wrestlingIncSnapshot = await FirebaseFirestore
          .instance
          .collection('WrestlingIncArticles')
          .get();
      final QuerySnapshot cultaholicSnapshot = await FirebaseFirestore.instance
          .collection('CultaholicArticles')
          .get();
      List<NewsArticleModel>? wrestlingIncNewsStories =
          wrestlingIncSnapshot.docs.map((doc) {
        return NewsArticleModel(
          articleTitle: doc['header'],
          articleDescription: doc['description'],
          articleLink: doc['link'],
          articleImage: doc['image_url'],
        );
      }).toList();
      List<NewsArticleModel>? cultaholicNewsStories =
          cultaholicSnapshot.docs.map((doc) {
        return NewsArticleModel(
          articleTitle: doc['header'],
          articleDescription: doc['description'],
          articleLink: doc['link'],
          articleImage: doc['image_url'],
        );
      }).toList();
      emit(
        NewsArticleLoaded(
          state.mainNewsArticleState.copyWith(
            wrestlingIncStories: wrestlingIncNewsStories,
            cultaholicStories: cultaholicNewsStories,
          ),
        ),
      );
    } catch (e) {
      emit(NewsArticleError(
          state.mainNewsArticleState, 'Failed to fetch news stories: $e'));
    }
  }
}
