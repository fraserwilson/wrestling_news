part of 'news_article_cubit.dart';

class MainNewsArticleState extends Equatable {
  final List<NewsArticleModel>? wrestlingIncStories;
  final List<NewsArticleModel>? cultaholicStories;

  const MainNewsArticleState({
    this.wrestlingIncStories,
    this.cultaholicStories,
  });

  MainNewsArticleState copyWith({
    List<NewsArticleModel>? wrestlingIncStories,
    List<NewsArticleModel>? cultaholicStories,
  }) {
    return MainNewsArticleState(
      wrestlingIncStories: wrestlingIncStories ?? this.wrestlingIncStories,
      cultaholicStories: cultaholicStories ?? this.cultaholicStories,
    );
  }

  @override
  List<Object?> get props => [
        wrestlingIncStories,
        cultaholicStories,
      ];
}

abstract class NewsArticleState extends Equatable {
  final MainNewsArticleState mainNewsArticleState;

  const NewsArticleState(this.mainNewsArticleState);

  @override
  List<Object?> get props => [mainNewsArticleState];
}

class NewsArticleInitial extends NewsArticleState {
  const NewsArticleInitial() : super(const MainNewsArticleState());
}

class NewsArticleLoading extends NewsArticleState {
  const NewsArticleLoading(MainNewsArticleState mainNewsArticleState)
      : super(mainNewsArticleState);
}

class NewsArticleLoaded extends NewsArticleState {
  const NewsArticleLoaded(MainNewsArticleState mainNewsArticleState)
      : super(mainNewsArticleState);
}

class NewsArticleError extends NewsArticleState {
  final String error;

  const NewsArticleError(MainNewsArticleState mainNewsArticleState, this.error)
      : super(mainNewsArticleState);
}
