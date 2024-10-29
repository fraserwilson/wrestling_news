import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_news/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:wrestling_news/cubits/news_article_cubit/news_article_cubit.dart';
import 'package:wrestling_news/firebase_options.dart';

import 'screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<NewsArticleCubit>(
            create: (context) => NewsArticleCubit(),
          ),
        ],
        child: const LandingScreen(),
      ),
    );
  }
}
