import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../services/firestore_service.dart';

class QuotesProvider extends ChangeNotifier {
  final String userId;
  final FirestoreService _firestoreService = FirestoreService();

  List<QuoteModel> favorites = [];
  List<QuoteModel> categoryQuotes = [];
  List<String> categories = [];
  bool isLoading = false;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  // Updated local category-based quotes
  final Map<String, List<String>> localQuotes = {
    "Motivation": [
      "Believe you can and you're halfway there.",
      "Start where you are. Use what you have. Do what you can.",
      "Push yourself, because no one else is going to do it for you.",
      "Small steps every day lead to big changes.",
      "Action is the foundational key to all success.",
      "Dream big, start small, act now.",
      "Your only limit is your mind.",
      "Focus on progress, not perfection.",
      "Energy and persistence conquer all things.",
      "Your future is created by what you do today, not tomorrow.",
    ],
    "Discipline": [
      "Discipline is choosing between what you want now and what you want most.",
      "Self-control is strength.",
      "Consistency beats motivation every time.",
      "Your habits define your success.",
      "Small disciplined actions lead to big achievements.",
      "Discipline creates freedom, laziness creates regret.",
      "Master yourself, master your life.",
      "Daily practice leads to lifelong excellence.",
      "The road to success is paved with discipline.",
      "Discipline is the silent architect of greatness.",
    ],
    "Success": [
      "Success is built one small win at a time.",
      "Hard work beats talent when talent doesn’t work hard.",
      "The key to success is to start before you are ready.",
      "Opportunities don’t happen. You create them.",
      "Greatness is achieved by ordinary people who refuse to quit.",
      "Success comes from effort, perseverance, and learning.",
      "Your attitude determines your altitude.",
      "Don’t just wait for opportunities—create them.",
      "Success is the sum of small efforts repeated consistently.",
      "Every success story begins with a single step.",
    ],
    "Habits": [
      "Habits shape your destiny.",
      "What you do today can improve all your tomorrows.",
      "Consistency is more important than perfection.",
      "Good habits are the foundation of a great life.",
      "Your habits reveal your priorities.",
      "Excellence is built on daily habits.",
      "The key to change is forming better habits.",
      "Habits are the invisible architecture of your life.",
      "Small actions repeated lead to massive results.",
      "Invest in habits that build the life you want.",
    ],
    "Growth": [
      "Growth happens outside your comfort zone.",
      "Every challenge is an opportunity to grow.",
      "The mind grows by stretching beyond the familiar.",
      "Your potential expands when you push your limits.",
      "Mistakes are stepping stones to growth.",
      "Growth requires patience and perseverance.",
      "Learning is the path to personal evolution.",
      "Change is growth in action.",
      "Adaptability is the key to continuous improvement.",
      "True growth begins when you embrace discomfort.",
    ],
    "Wisdom": [
      "The only true wisdom is knowing you know nothing.",
      "Patience is the companion of wisdom.",
      "Wisdom begins in wonder.",
      "Turn your wounds into wisdom.",
      "A wise person learns more from mistakes than from success.",
      "Knowledge speaks, but wisdom listens.",
      "Silence is the sleep that nourishes wisdom.",
      "See the extraordinary in the ordinary.",
      "Wisdom comes with reflection and experience.",
      "The measure of intelligence is the ability to change.",
    ],
    "Mindfulness": [
      "Be where you are, not where you think you should be.",
      "Mindfulness is the aware, balanced acceptance of the present experience.",
      "Every morning we are born again. What we do today matters most.",
      "Feelings come and go like clouds. Breathe and observe.",
      "Walk as if you are kissing the Earth with your feet.",
      "The present moment is filled with joy and happiness.",
      "Mindfulness isn’t difficult; we just need to remember to do it.",
      "Peace comes from within. Do not seek it without.",
      "Smile, breathe, and go slowly.",
      "Awareness of the now is the path to serenity.",
    ],
  };

  QuotesProvider({required this.userId}) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await Future.wait([
      loadFavorites(),
      loadCategories(),
    ]);
  }

  Future<void> loadCategories() async {
    categories = localQuotes.keys.toList();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    isLoading = true;
    notifyListeners();

    favorites = await _firestoreService.getFavoriteQuotes(userId);

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadQuotesByCategory(String category) async {
    isLoading = true;
    _selectedCategory = category;
    notifyListeners();

    if (localQuotes.containsKey(category)) {
      categoryQuotes = localQuotes[category]!
          .asMap()
          .entries
          .map(
            (entry) => QuoteModel(
          id: '${category}_${entry.key}',
          text: entry.value,
          author: category,
          tags: [category],
          isFavorite:
          favorites.any((f) => f.id == '${category}_${entry.key}'),
        ),
      )
          .toList();
    } else {
      categoryQuotes = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(QuoteModel quote) async {
    final updatedQuote = quote.copyWith(isFavorite: !quote.isFavorite);

    if (updatedQuote.isFavorite) {
      await _firestoreService.addFavoriteQuote(userId, updatedQuote);
    } else {
      await _firestoreService.removeFavoriteQuote(userId, updatedQuote);
    }

    await loadFavorites();
  }
}
