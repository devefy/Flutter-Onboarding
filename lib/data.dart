import 'dart:ui';

var pageList = [
  PageModel(
      imageUrl: "assets/illustration.png",
      title: "MUSIC",
      body: "EXPERIENCE WICKED PLAYLISTS",
      titleGradient: [Color(0xFF9708CC), Color(0xFF43CBFF)]),
  PageModel(
      imageUrl: "assets/illustration2.png",
      title: "SPA",
      body: "FEEL THE MAGIC OF WELLNESS",
      titleGradient: [Color(0xFFE2859F), Color(0xFFFCCF31)]),
  PageModel(
      imageUrl: "assets/illustration3.png",
      title: "TRAVEL",
      body: "LET'S HIKE UP",
      titleGradient: [Color(0xFF5EFCE8), Color(0xFF736EFE)]),
];

class PageModel {
  String imageUrl;
  String title;
  String body;
  List<Color> titleGradient = [];
  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}
