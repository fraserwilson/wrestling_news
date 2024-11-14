import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_news/components/wrestling_news_card.dart';
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
            return Column(
              children: [
                Expanded(
                  child: WrestlingNewsCard(
                    items: state.mainNewsArticleState.wrestlingArticles ?? [],
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
