import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_bloom/QuoteController.dart';
import 'package:mind_bloom/views/article_screen.dart';
import 'package:mind_bloom/views/emotion_screen.dart'; 
import 'package:mind_bloom/views/exercice_screen.dart';
import 'package:mind_bloom/views/gratitude_screen.dart';
import 'package:mind_bloom/views/favorite_quotes_screen.dart';
import 'package:mind_bloom/views/video_screen.dart';
import '../mock_data/quotes.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RxString currentQuote = ''.obs;
  int _selectedIndex = 0;
  bool isLoading = false;

  void getRandomQuote() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 1)); // ba3ed 1seconde tetaficha citation 
    final quote = quotes[(quotes.length * Random().nextDouble()).floor()];
    currentQuote.value = quote;
    setState(() => isLoading = false);
    showQuoteDialog(quote);
  }

  void showQuoteDialog(String quote) {
    final QuoteController quoteController = Get.find();

    Get.defaultDialog(
      title: 'Citation du jour',
      content: Column(
        children: [
          Text(
            quote,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Obx(() => IconButton(
            icon: Icon(
              quoteController.favoriteQuotes.contains(quote)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              if (quoteController.favoriteQuotes.contains(quote)) {
                quoteController.removeFavoriteQuote(quote);
              } else {
                quoteController.addFavoriteQuote(quote);
              }
            },
          )),
        ],
      ),
      confirm: TextButton(
        onPressed: () => Get.back(),
        child: Text('Fermer'),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA), // Couleur de fond principale
      appBar: AppBar(
        title: _selectedIndex == 0
            ? Text('Émotion')
            : _selectedIndex == 1
                ? Text('Citations')
                : _selectedIndex == 2
                    ? Text('Citations favorites')
                    : _selectedIndex == 3
                        ? Text('Gratitude')
                        : Text('Exercices'),
        backgroundColor: Colors.blue.shade200, // Bleu pastel
        elevation: 0,
        actions: _selectedIndex == 0
            ? [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ]
            : null,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFEAEAEA), 
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('OUNI Siwar'),
                accountEmail: Text('osiwar20@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200, 
                ),
              ),
              ListTile(
                leading: Icon(Icons.article, color: Colors.blue.shade900),
                title: Text('Articles', style: TextStyle(color: Colors.blue.shade900)),
                onTap: () {
                  Navigator.pop(context); 
                  Get.to(() => ArticleScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library, color: Colors.blue.shade900),
                title: Text('Vidéos', style: TextStyle(color: Colors.blue.shade900)),
                onTap: () {
                  Navigator.pop(context); 
                  Get.to(() => VideoScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.music_note, color: Colors.blue.shade900),
                title: Text('Musique', style: TextStyle(color: Colors.blue.shade900)),
                onTap: () {
                  Navigator.pop(context); 
                  // Get.to(() => VideosScreen());
                },
              ),
              Divider(color: Colors.blue.shade900),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.blue.shade900),
                title: Text('Paramètres', style: TextStyle(color: Colors.blue.shade900)),
                onTap: () {
                  Navigator.pop(context); 
                  // Get.to(() => SettingsScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.blue.shade900),
                title: Text('Aide', style: TextStyle(color: Colors.blue.shade900)),
                onTap: () {
                  Navigator.pop(context); 
                  // Get.to(() => HelpScreen());
                },
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          EmotionScreen(),
          // Page de citations
          Stack(
            children: [
              // Image en arrière-plan
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/fleur.jpg'), // Chemin de l'image
                    fit: BoxFit.cover, // Ajuste l'image pour couvrir tout l'écran
                  ),
                ),
              ),
              // Contenu de la page
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.all(16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            isLoading
                                ? CircularProgressIndicator()
                                : AnimatedOpacity(
                                    opacity: currentQuote.value.isEmpty ? 0 : 1,
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      currentQuote.value,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: getRandomQuote,
                              child: Text('Générer une citation'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Page de favoris
          FavoriteQuotesScreen(),
          // Page de gratitude
          GratitudeScreen(),
          // Page d'exercices
          ExerciceScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFEAEAEA), // Couleur de fond de la BottomNavigationBar
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.blue.shade700,
        selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        iconSize: 28,
        elevation: 10,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Émotion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Citations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events), // Nouvelle icône pour la gratitude
            label: 'Gratitude',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: 'Exercices',
          ),
        ],
      ),
    );
  }
}