import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../word_of_the_day/application/word_provider.dart';
import '../../../word_of_the_day/domain/models/word.dart';
import '../widgets/favorite_word_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Word>> _favoriteWordsFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final wordProvider = Provider.of<WordProvider>(context, listen: false);
    _favoriteWordsFuture = wordProvider.loadFavoriteWords();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return Text(
              AppTranslations.translate('favorite_words', languageProvider.currentLanguage)
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Word>>(
        future: _favoriteWordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Consumer<LanguageProvider>(
                builder: (context, languageProvider, _) {
                  return Text(
                    AppTranslations.translate('error_loading_favorites', languageProvider.currentLanguage),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  );
                },
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 64,
                    color: isDarkMode ? Colors.white30 : Colors.black26,
                  ),
                  const SizedBox(height: 16),
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, _) {
                      return Text(
                        AppTranslations.translate('no_favorites', languageProvider.currentLanguage),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, _) {
                      return Text(
                        AppTranslations.translate('add_favorites_hint', languageProvider.currentLanguage),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.white54 : Colors.black45,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            final favorites = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final word = favorites[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FavoriteWordCard(
                    word: word,
                    onRemove: () async {
                      final wordProvider = Provider.of<WordProvider>(context, listen: false);
                      await wordProvider.toggleFavorite(word: word);
                      if (mounted) {
                        setState(() {
                          _loadFavorites();
                        });
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
