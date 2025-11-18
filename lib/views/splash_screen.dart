import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    
    _controller = AnimationController(
      duration: const Duration(seconds: 2), 
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

   //animation
    _controller.forward();

    
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/home'); 
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Nettoyer l'animation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: Stack(
        children: [
          // Image en arrière-plan
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/one.jpg'), 
                fit: BoxFit.cover, // Ajuster l'image pour tout l'écran
              ),
            ),
          ),
          // Contenu superposé
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animation pour le texte "MindBloom"
                FadeTransition(
                  opacity: _animation,
                  child: Text(
                    'MindBloom',
                    style: TextStyle(
                      fontSize: 36, // Taille du texte
                      fontWeight: FontWeight.bold, // Texte en gras
                      color: Colors.lightBlue, // Couleur du texte
                    ),
                  ),
                ),
                SizedBox(height: 30), 
                // Texte "Welcome" 
                FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)), 
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 28, 
                          fontWeight: FontWeight.bold, 
                          color: const Color.fromARGB(255, 177, 69, 118), 
                        ),
                      );
                    } else {
                      return SizedBox(); // Ne rien afficher avant 2 secondes
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}