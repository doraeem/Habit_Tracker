import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/quotes_provider.dart';
import '../../constants/app_colors.dart';
import '../../widgets/quote_card.dart';

class QuotesCategoryScreen extends StatelessWidget {
  final String category;

  const QuotesCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuotesProvider>(
      builder: (context, quotesProvider, _) {
        final quotes = quotesProvider.categoryQuotes;
        final isLoading = quotesProvider.isLoading;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF4A148C), // Deep lavender
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF4A148C)),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE6E6FA), // Light lavender
                  Color(0xFFBA68C8), // Lavender
                  Color(0xFF6A1B9A), // Deep lavender
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4A148C),
              ),
            )
                : quotes.isEmpty
                ? const Center(
              child: Text(
                "No quotes available",
                style: TextStyle(
                  color: Color(0xFF4A148C),
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final quote = quotes[index];
                final isCurrentlyFavorite =
                quotesProvider.favorites
                    .any((favQuote) => favQuote.id == quote.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: QuoteCard(
                        quote: quote,
                        isFavorite: isCurrentlyFavorite,
                        onFavoriteToggle: () {
                          quotesProvider.toggleFavorite(quote);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
