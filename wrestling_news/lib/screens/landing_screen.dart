import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_news/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:wrestling_news/cubits/news_article_cubit/news_article_cubit.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    signInAnon();
    fetchNewsStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Stories'),
      ),
      body: BlocBuilder<NewsArticleCubit, NewsArticleState>(
        builder: (context, state) {
          if (state is NewsArticleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsArticleLoaded) {
            return Row(
              children: [
                // Column for the first list of articles
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        state.mainNewsArticleState.wrestlingIncStories?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          state.mainNewsArticleState.wrestlingIncStories?[index]
                                  .articleTitle ??
                              '',
                        ),
                      );
                    },
                  ),
                ),
                // Column for the second list of articles
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        state.mainNewsArticleState.cultaholicStories?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          state.mainNewsArticleState.cultaholicStories?[index]
                                  .articleTitle ??
                              '',
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is NewsArticleError) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return const Center(
            child: Text('No news stories available.'),
          );
        },
      ),
    );
  }

  Future<void> signInAnon() async {
    BlocProvider.of<AuthCubit>(context).signInAnon();
  }

  Future<void> fetchNewsStories() async {
    BlocProvider.of<NewsArticleCubit>(context).fetchNewsStories();
  }
}
