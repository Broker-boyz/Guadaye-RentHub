import 'package:flutter/material.dart';

import 'news_container.dart';
import 'news_data.dart';

class JournalNewsPage extends StatefulWidget {
  @override
  _JournalNewsPageState createState() => _JournalNewsPageState();
}

class _JournalNewsPageState extends State<JournalNewsPage> {
  List<NewsItem> newsItems = [];

  @override
  void initState() {
    super.initState();
    newsItems = [
      NewsItem(
        title: 'Breaking News ',
        image: 'lib/assets/images.jfif',
        description:
            'Experts suggest that incorporating indoor plants into your home decor not only adds a touch of nature but also helps improve indoor air quality. Consider adding a few low-maintenance plants like spider plants or pothos to enhance the ambiance of your living space.',
      ),
      NewsItem(
        title: 'Feature Story',
        image: 'lib/assets/download (6).jfif',
        description:
            'Experts suggest that incorporating indoor plants into your home decor not only adds a touch of nature but also helps improve indoor air quality. Consider adding a few low-maintenance plants like spider plants or pothos to enhance the ambiance of your living space.',
      ),
      NewsItem(
        title: 'Feature Story',
        image: 'lib/assets/download (6).jfif',
        description:
            'Experts suggest that incorporating indoor plants into your home decor not only adds a touch of nature but also helps improve indoor air quality. Consider adding a few low-maintenance plants like spider plants or pothos to enhance the ambiance of your living space.',
      ),
      NewsItem(
        title: 'Feature Story',
        image: 'lib/assets/download (6).jfif',
        description:
            'Experts suggest that incorporating indoor plants into your home decor not only adds a touch of nature but also helps improve indoor air quality. Consider adding a few low-maintenance plants like spider plants or pothos to enhance the ambiance of your living space.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return NewsContainer(newsItem: newsItems[index]);
        },
      ),
    );
  }
}
