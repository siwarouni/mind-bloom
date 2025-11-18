import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importez le package url_launcher

class ArticleScreen extends StatelessWidget {
  // Liste d'articles (exemple)
  final List<Map<String, dynamic>> articles = [
    {
      'title': 'Thérapie',
      'image': 'assets/images/therapy.jpg',
      'content': 'Contenu de l\'article sur la thérapie...',
      'link': 'https://www.em-consulte.com/revue/THERAP/presentation/therapies', 
    },
    {
      'title': 'Journal de réflexion',
      'image': 'assets/images/journal.jpg',
      'content': 'Contenu du journal de réflexion...',
      'link': 'https://ecampusontario.pressbooks.pub/cmnsantedi/front-matter/pre-evaluation/', 
    },
    {
      'title': 'Wellness',
      'image': 'assets/images/wellness.jpg',
      'content': 'Contenu de l\'article sur le wellness...',
      'link': 'https://www.everydayhealth.com/wellness/', 
    },
    // Ajouter un nouvel article avec un lien externe
    {
      'title': 'Gestion du stress',
      'image': 'assets/images/stress.jpg',
      'content': 'Découvrez des techniques pour gérer votre stress au quotidien...',
      'link': 'https://www.exemple.com/gestion-du-stress', // Lien externe
    },
  ];

  ArticleScreen({super.key});

  // Fn n7el beha lien externe
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Impossible d\'ouvrir le lien : $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
        backgroundColor: Colors.blue.shade300, // Couleur de l'AppBar
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              if (article['link'] != null) {
                //7el lien
                _launchURL(article['link']);
              } else {
                // Naviguer vers la page de détails de l'article
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailScreen(
                      title: article['title'],
                      image: article['image'],
                      content: article['content'],
                    ),
                  ),
                );
              }
            },
            child: Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image de l'article
                  Image.asset(
                    article['image'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  // Titre de l'article
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      article['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Page de détails de l'article
class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String content;

  const ArticleDetailScreen({super.key, 
    required this.title,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de l'article
            Image.asset(
              image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // Titre de l'article
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 10),
            // Contenu de l'article
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}