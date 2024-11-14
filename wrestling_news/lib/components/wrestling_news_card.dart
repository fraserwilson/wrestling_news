import 'package:flutter/material.dart';
import 'package:wrestling_news/components/animated_card_item.dart';
import 'package:wrestling_news/models/news_article_model.dart';

class WrestlingNewsCard extends StatefulWidget {
  final List<NewsArticleModel> items;

  const WrestlingNewsCard({
    required this.items,
  });

  @override
  State<WrestlingNewsCard> createState() => _WrestlingNewsCardState();
}

class _WrestlingNewsCardState extends State<WrestlingNewsCard>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemCount: widget.items.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 56),
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedCardItem(
              title: widget.items[index].articleTitle,
              subtitle: widget.items[index].articleDescription,
              image: widget.items[index].articleImage,
              isExpanded: _selectedIndex == index,
              animation: _controller,
              onTap: () => onExpand(_selectedIndex == index ? -1 : index),
            ),
          );
        },
      ),
    );
  }

  void onExpand(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
