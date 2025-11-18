import 'package:get/get.dart';
import 'package:mind_bloom/views/article_screen.dart';
import 'package:mind_bloom/views/video_screen.dart';
import '../views/home_screen.dart';
import '../views/emotion_screen.dart';
import '../views/gratitude_screen.dart';
import '../views/exercice_screen.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(name: '/emotion', page: () => EmotionScreen()),
    GetPage(name: '/gratitude', page: () => GratitudeScreen()),
    GetPage(name: '/exercice', page: () => ExerciceScreen()),
    GetPage(name: '/video', page: () => VideoScreen()),
    GetPage(name: '/article', page: () => ArticleScreen()),

  ];
}