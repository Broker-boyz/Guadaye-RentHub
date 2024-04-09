import 'package:flutter/material.dart';
import 'package:hackathon/pages/newspage/videodata.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  int _currentIndex = 0;
  void _playVideo({int index = 0, bool init = false}) async {
    if (index < 0 || index >= videos.length) return;
    if (!init) {
      _controller.pause();
    }
    setState(() => _currentIndex = index);
    String videoAssetPath = videos[_currentIndex].url;
    _controller = VideoPlayerController.asset(videoAssetPath)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }

  @override
  void initState() {
    super.initState();
    _playVideo(init: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.deepPurpleAccent,
            height: 315,
            child: _controller.value.isInitialized
                ? Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: VideoPlayer(_controller),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _controller,
                            builder: (context, VideoPlayerValue, child) {
                              return Text(
                                _videoDuration(_controller.value.position),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 10,
                              child: VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        },
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Expanded(
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
                      ),
                      SizedBox()
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
          SizedBox(
            height: screenHeight - 315, // Adjusted height based on screen height
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _playVideo(index: index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset(
                            videos[index].thumbnail,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            videos[index].name,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        Expanded(child: Icon(Icons.more_vert)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
