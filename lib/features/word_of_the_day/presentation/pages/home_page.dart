import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/word_provider.dart';
import '../widgets/word_display.dart';
import '../widgets/word_example.dart';
import '../widgets/action_buttons.dart';
import '../../../../features/settings/presentation/pages/settings_page.dart';
import '../../../../features/favorites/presentation/pages/favorites_page.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/widgets/language_selector.dart';
import '../../../../core/localization/translation_service.dart';
import '../../../../core/localization/app_translations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WordProvider>(context, listen: false).loadTodaysWord();
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Consumer<WordProvider>(
        builder: (context, wordProvider, child) {
          if (wordProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final themeProvider = Provider.of<ThemeProvider>(context);
          final isDarkMode = themeProvider.isDarkMode;
          final separatorColor = isDarkMode ? Colors.white : Colors.black;
          
          return FadeTransition(
            opacity: _fadeAnimation,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 40,
                    color: isDarkMode ? Colors.black : Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: separatorColor.withOpacity(0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const LanguageSelector(),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.local_fire_department,
                                        color: Colors.orange,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${wordProvider.streak}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          WordDisplay(word: wordProvider.currentWord),
                          const Spacer(),
                          WordExample(
                            example: wordProvider.currentWord.example,
                            word: wordProvider.currentWord.word,
                          ),
                          const SizedBox(height: 60),
                          ActionButtons(
                            isFavorite: wordProvider.isFavorite,
                            onFavoriteToggle: () => wordProvider.toggleFavorite(),
                            wordToSpeak: wordProvider.currentWord.word,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return BottomAppBar(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tooltip(
                    message: AppTranslations.translate('home', languageProvider.currentLanguage),
                    child: IconButton(
                      icon: const Icon(Icons.home_outlined),
                      onPressed: () {},
                    ),
                  ),
                  Tooltip(
                    message: AppTranslations.translate('favorites', languageProvider.currentLanguage),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritesPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Tooltip(
                    message: AppTranslations.translate('settings', languageProvider.currentLanguage),
                    child: IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
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
