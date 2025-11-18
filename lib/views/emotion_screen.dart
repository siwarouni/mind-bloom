import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../mock_data/emotions.dart';

class EmotionScreen extends StatelessWidget {
  final RxString selectedEmotion = ''.obs;
  final RxList<Map<String, String>> emotionJournal = <Map<String, String>>[].obs;

  EmotionScreen({super.key});

  void showAdvice(String emotion) {
    Get.defaultDialog(
      title: 'Conseil',
      content: Text(emotionAdvice[emotion]!),
      confirm: TextButton(
        onPressed: () => Get.back(),
        child: Text('OK'),
      ),
    );
  }

  void saveEmotion() {
    if (selectedEmotion.value.isEmpty) {
      Get.snackbar('Erreur', 'Sélectionne une émotion avant d\'enregistrer.');
      return;
    }

    // Vérifier si la dernière émotion enregistrée est la même
    if (emotionJournal.isNotEmpty &&
        emotionJournal.last['emotion'] == selectedEmotion.value) {
      Get.snackbar('Info', 'Tu as déjà enregistré cette émotion récemment.');
      return;
    }

    // Enregistrer l'émotion avec la date actuelle
    final now = DateTime.now();
    final formattedDate = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}';
    emotionJournal.add({
      'emotion': selectedEmotion.value,
      'date': formattedDate,
    });

    Get.snackbar('Succès', 'Émotion enregistrée : ${selectedEmotion.value}');
  }

  // Méthode pour obtenir l'icône en fonction de l'émotion
  IconData getEmotionIcon(String emotion) {
    switch (emotion) {
      case 'content':
        return Icons.sentiment_very_satisfied;
      case 'normal':
        return Icons.sentiment_neutral;
      case 'triste':
        return Icons.sentiment_very_dissatisfied;
      case 'en colère':
        return Icons.sentiment_very_dissatisfied; // Ou une autre icône appropriée
      case 'stressé':
        return Icons.sentiment_very_dissatisfied; // Ou une autre icône appropriée
      default:
        return Icons.sentiment_neutral; // Icône par défaut
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image en arrière-plan
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/smile.jpg'), // Chemin de l'image
                fit: BoxFit.cover, // Ajuster l'image pour couvrir tout l'écran
              ),
            ),
          ),
          // Contenu de la page
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Section pour sélectionner une émotion
                Text(
                  'Comment te sens-tu aujourd\'hui ?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildEmotionButton('content', 'Content'),
                    _buildEmotionButton('normal', 'Normal'),
                    _buildEmotionButton('triste', 'Triste'),
                    _buildEmotionButton('en colère', 'En colère'),
                    _buildEmotionButton('stressé', 'Stressé'),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() => Text(
                  selectedEmotion.value.isEmpty
                      ? 'Sélectionne une émotion'
                      : 'Tu te sens ${selectedEmotion.value} aujourd\'hui.',
                  style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveEmotion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade300, // Bouton en bleu
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Enregistrer mon émotion', style: TextStyle(fontSize: 16, )),
                ),
                SizedBox(height: 20),

                // Section pour afficher le journal d'émotions
                Expanded(
                  child: Obx(() => emotionJournal.isEmpty
                      ? Center(
                          child: Text(
                            'Aucune émotion enregistrée pour le moment.',
                            style: TextStyle(fontSize: 16, color: Colors.pink),
                          ),
                        )
                      : ListView.builder(
                          itemCount: emotionJournal.length,
                          itemBuilder: (context, index) {
                            final entry = emotionJournal[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white.withOpacity(0.8), // Fond semi-transparent
                              child: ListTile(
                                title: Text('Émotion: ${entry['emotion']}', style: TextStyle(color: Colors.blue.shade900)),
                                subtitle: Text('Date: ${entry['date']}', style: TextStyle(color: Colors.blue.shade700)),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.blueGrey),
                                  onPressed: () {
                                    emotionJournal.removeAt(index);
                                    Get.snackbar('Succès', 'Émotion supprimée');
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour construire un bouton d'émotion
  Widget _buildEmotionButton(String emotion, String label) {
    return GestureDetector(
      onTap: () {
        selectedEmotion.value = emotion;
        showAdvice(emotion);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selectedEmotion.value == emotion
              ? Colors.blue.shade300.withOpacity(0.8) // Fond semi-transparent
              : Colors.blue.shade100.withOpacity(0.8), // Fond semi-transparent
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(getEmotionIcon(emotion), size: 40, color: Colors.blue.shade900),
            SizedBox(height: 10),
            Text(label, style: TextStyle(color: Colors.blue.shade900)),
          ],
        ),
      ),
    );
  }
}