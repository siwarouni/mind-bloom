import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Pour ouvrir des liens externes

class VideoScreen extends StatelessWidget {
  // Liste des podcasts sur la santé mentale avec des titres, descriptions et liens YouTube
  final List<Map<String, String>> podcasts = [
    {
      'title': 'تعلم كيف تحسن الظن بالله',
      'description': '',
      'url': 'https://www.youtube.com/watch?v=mCnSGGw_SNU', 
    },
    {
      'title': 'The Mental Health Doctor',
      'description': 'Your Phone Screen & Sitting Is Destroying Your Brain',
      'url': 'https://www.youtube.com/watch?v=FN0_ow76hU8', 
    },
    {
      'title': 'Stress',
      'description': 'trois astuces pour réduire son anxiété au quotidien',
      'url': 'https://www.youtube.com/watch?v=j-u9nRPsHdU', 

    },
  ];

  // Fn ouvrir lirn youtube dans navigateur
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le lien : $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      appBar: AppBar(
        title: Text('Podcasts'),
        backgroundColor: Colors.blue.shade300,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Retour à la HomeScreen
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: podcasts.length,
        itemBuilder: (context, index) {
          final podcast = podcasts[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey,
            child: InkWell(
              onTap: () {
                // Ouvrir le lien YouTube lorsqu'on clique sur la carte
                _launchURL(podcast['url']!);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image de la vidéo (optionnelle)
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.penser-et-agir.fr%2Fgestion-du-stress%2F&psig=AOvVaw2Q4QhBQDchoZbux6v_p0Xk&ust=1740270027095000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKiN3qGB1osDFQAAAAAdAAAAABAE'), // Remplace par une vraie image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Titre et description du podcast
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          podcast['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          podcast['description']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
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