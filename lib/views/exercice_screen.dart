import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciceScreen extends StatelessWidget {
  // Liste des catégories avec leurs exercices
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Relaxation',
      'exercices': [
        {
          'title': 'Respiration profonde',
          'description': 'Un exercice simple pour réduire le stress.',
          'steps': '''
1. Asseyez-vous confortablement.
2. Fermez les yeux et inspirez profondément par le nez.
3. Retenez votre respiration pendant 3 secondes.
4. Expirez lentement par la bouche.
5. Répétez pendant 5 minutes.
''',
          'image': 'assets/images/relaxation.jpg', // Chemin de l'image
        },
        {
          'title': 'Relaxation musculaire progressive',
          'description': 'Détendez vos muscles pour réduire le stress.',
          'steps': '''
1. Asseyez-vous ou allongez-vous confortablement.
2. Commencez par les pieds : contractez les muscles pendant 5 secondes, puis relâchez.
3. Remontez progressivement vers les jambes, le ventre, les bras, et enfin le visage.
4. Répétez pour chaque groupe musculaire.
5. Terminez par une respiration profonde.
''',
          'image': 'assets/images/relaxation.jpg', // Chemin de l'image
        },
      ],
    },
    {
      'name': 'Méditation',
      'exercices': [
        {
          'title': 'Méditation guidée',
          'description': 'Une méditation pour calmer l\'esprit.',
          'steps': '''
1. Trouvez un endroit calme.
2. Asseyez-vous ou allongez-vous confortablement.
3. Fermez les yeux et concentrez-vous sur votre respiration.
4. Suivez les instructions de la méditation guidée.
5. Pratiquez pendant 10 à 15 minutes.
''',
          'image': 'assets/images/meditation.jpeg', // Chemin de l'image
        },
        {
          'title': 'Méditation de pleine conscience',
          'description': 'Concentrez-vous sur le moment présent.',
          'steps': '''
1. Asseyez-vous confortablement et fermez les yeux.
2. Concentrez-vous sur votre respiration.
3. Si des pensées surgissent, observez-les sans jugement et revenez à votre respiration.
4. Pratiquez pendant 5 à 10 minutes.
''',
          'image': 'assets/images/meditation.jpeg', // Chemin de l'image
        },
      ],
    },
    {
      'name': 'Gratitude',
      'exercices': [
        {
          'title': 'Journal de gratitude',
          'description': 'Écrivez ce pour quoi vous êtes reconnaissant.',
          'steps': '''
1. Prenez un moment pour réfléchir à votre journée.
2. Écrivez 3 choses pour lesquelles vous êtes reconnaissant.
3. Concentrez-vous sur les petits détails.
4. Répétez cet exercice quotidiennement.
''',
          'image': 'assets/images/gratitude.png', // Chemin de l'image
        },
        {
          'title': 'Exercice de gratitude',
          'description': 'Concentrez-vous sur les aspects positifs de la vie.',
          'steps': '''
1. Prenez un moment pour réfléchir à votre journée.
2. Écrivez 3 choses pour lesquelles vous êtes reconnaissant.
3. Concentrez-vous sur les petits détails (par exemple, un sourire, un bon repas).
4. Répétez cet exercice quotidiennement.
''',
          'image': 'assets/images/gratitude.png', // Chemin de l'image
        },
      ],
    },
  ];

  ExerciceScreen({super.key});

  // Fn t affichichi les exercice fi dialog
  void showExerciceSteps(BuildContext context, String title, String steps, String imagePath) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blue, // Couleur du titre
      ),
      content: Column(
        children: [
          Image.asset(
            imagePath, // Chemin de l'image
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            child: Text(
              steps,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87, // Couleur du texte
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white, // Couleur dialogue
      radius: 10, // Bordure arrondie
      confirm: ElevatedButton.icon(
        onPressed: () => Get.back(),
        icon: Icon(Icons.check, color: Colors.white),
        label: Text(
          'Fermer',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Couleur du bouton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordure arrondie du bouton
        ),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA), // Changement de la couleur de fond ici
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, categoryIndex) {
          final category = categories[categoryIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,// tcontroli l alignement mte3 l widget
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: category['exercices'].length,
                itemBuilder: (context, exerciceIndex) {
                  final exercice = category['exercices'][exerciceIndex];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(
                        exercice['image'], // Chemin de l'image
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(exercice['title']),
                      subtitle: Text(exercice['description']),
                      onTap: () {
                        showExerciceSteps(context, exercice['title'], exercice['steps'], exercice['image']);
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}