class video{
  final String name;
  final String url;
  final String thumbnail;
  const video(
    {required this.name, required this.url, required this.thumbnail});
}

const videos =[
  video(name: 'welcome', url: 'lib/assets/bizuayehu.mp4', thumbnail: 'lib/assets/download (6).jfif'),
  video(name: 'search what you want !', url: 'lib/assets/amharicmusic.mp4', thumbnail: 'lib/assets/images.jfif'),
  video(name: 'welcome to Gojo app', url: 'lib/assets/bizuayehu.mp4', thumbnail: 'lib/assets/image.png'),
  video(name: 'welcome', url: 'lib/assets/bizuayehu.mp4', thumbnail: 'lib/assets/images.jfif'),
  video(name: 'Hey there!', url: 'lib/assets/bizuayehu.mp4', thumbnail: 'lib/assets/image.png'),
  video(name: 'what do you want', url: 'lib/assets/bizuayehu.mp4', thumbnail: 'lib/assets/images.jfif'),
];