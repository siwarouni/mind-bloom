import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_bloom/QuoteController.dart';

class FavoriteQuotesScreen extends StatelessWidget {
  final QuoteController quoteController = Get.find();

  FavoriteQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA), 
      
      body: Obx(() => ListView.builder(
        padding: EdgeInsets.all(16.0), 
        itemCount: quoteController.favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = quoteController.favoriteQuotes[index];
          return Card(
            elevation: 4, 
            margin: EdgeInsets.only(bottom: 16), 
            child: ListTile(
              title: Text(
                quote,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade900, 
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.blueGrey),
                onPressed: () {
                  quoteController.removeFavoriteQuote(quote);
                },
              ),
            ),
          );
        },
      )),
    );
  }
}