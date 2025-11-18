import 'package:get/get.dart';

class QuoteController extends GetxController {
  var favoriteQuotes = <String>[].obs;// .obs heya eli tkhali k tssir ay modification fl page ta3mel mise a jours 

  void addFavoriteQuote(String quote) {
    if (!favoriteQuotes.contains(quote)) {
      favoriteQuotes.add(quote);
    }
  }

  void removeFavoriteQuote(String quote) {
    favoriteQuotes.remove(quote);
  }
}