import 'package:flutter/material.dart';
import 'package:hackathon/pages/newspage/journalnews.dart';
import 'package:hackathon/pages/newspage/videoplayerpage.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    Key? key,
  });

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String selectedOption = 'Journal';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('lib/assets/image.png'),
                radius: 30,
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'Journal';
                  });
                },
                child: Text('Journal'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'TV News';
                  });
                },
                child: Text('TV News'),
              ),
            ],
          ),
          if (selectedOption == 'Journal') JournalNewsPage(),
          if (selectedOption == 'TV News') VideoPlayerPage(),
        ],
      ),
    );
  }
}
