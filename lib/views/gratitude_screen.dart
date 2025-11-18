import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GratitudeScreen extends StatelessWidget {
  final RxList<String> entries = <String>[].obs;
  final TextEditingController entryController = TextEditingController();// fournie par flutter bech nrecupériw beha eli mawjoud f textfield

  GratitudeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEAEAEA), 
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Écris quelque chose pour lequel tu es reconnaissant aujourd\'hui :',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              TextField(
                controller: entryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Entrée',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (entryController.text.isNotEmpty) {
                    entries.add('😊 ${entryController.text}');
                    entryController.clear();
                    Get.snackbar('Succès', 'Entrée enregistrée avec succès !');
                  } else {
                    Get.snackbar('Erreur', 'L\'entrée ne peut pas être vide.');
                  }
                },
                child: Text('Enregistrer'),
              ),
              SizedBox(height: 20),
             
              Obx(() => Expanded(
                child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(entries[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            entries.removeAt(index);
                          },
                        ),
                        onTap: () {
                          entryController.text = entries[index].replaceAll('😊 ', '');
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Modifier l\'entrée'),
                                content: TextField(controller: entryController),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      entries[index] = '😊 ${entryController.text}';
                                      entryController.clear();
                                      Get.back();
                                    },
                                    child: Text('Enregistrer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              )),
            ],
          ),
        ),
     // ),
    );
  }
}