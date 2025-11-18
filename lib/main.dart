import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_bloom/QuoteController.dart'; // Importez votre contrôleur
import 'package:mind_bloom/views/splash_screen.dart'; // Importez le SplashScreen
import 'routes.dart'; // Importez votre fichier de routes

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisez les contrôleurs ici
    Get.put(QuoteController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindBloom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade100,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/splash', 
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()), 
        ...AppRoutes.routes, 
      ],
    );
  }
}