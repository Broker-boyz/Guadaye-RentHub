import 'package:flutter/material.dart';

import 'news_data.dart';

class NewsContainer extends StatelessWidget {
  final NewsItem newsItem;

  NewsContainer({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${newsItem.title}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(newsItem.image),
            ],
          ),
          SizedBox(height: 10),
          Text('${newsItem.description}'),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.thumb_up),
                Icon(Icons.thumb_down),
                Icon(Icons.share),
                Icon(Icons.comment),
              ],
            ),
          )
        ],
      ),
    );
  }
}
