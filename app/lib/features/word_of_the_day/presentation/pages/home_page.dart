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
import '../../../../core/localization/app_translations.dart';
import '../../../../core/utils/word_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  LanguageProvider? _languageProvider;
  
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
      _languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      _languageProvider!.addListener(_onLanguageChanged);
    });
  }
  
  void _onLanguageChanged() {
    final wordProvider = Provider.of<WordProvider>(context, listen: false);
    final code = _languageProvider!.currentLanguage == AppLanguage.french ? 'fr' : 'en';
    wordProvider.setLanguage(code);
    setState(() {});
  }
  
  @override
  void dispose() {
    _languageProvider?.removeListener(_onLanguageChanged);
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
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    height: 50,
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
                          padding: const EdgeInsets.only(bottom: 1, top: 8), // Ajout d'un padding supérieur
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
                          Consumer<LanguageProvider>(
                            builder: (context, languageProvider, _) {
                              String translatedWord = wordProvider.currentWord.word;
                              
                              if (languageProvider.currentLanguage == AppLanguage.english) {
                                final translation = WordUtils.getTranslation(wordProvider.currentWord, 'en');
                                if (translation != null) {
                                  translatedWord = translation.word;
                                }
                              }
                              
                              return ActionButtons(
                                isFavorite: wordProvider.isFavorite,
                                onFavoriteToggle: () => wordProvider.toggleFavorite(),
                                wordToSpeak: translatedWord,
                                definition: wordProvider.currentWord.definition,
                                example: wordProvider.currentWord.example,
                                wordType: wordProvider.currentWord.type,
                                onReroll: () => wordProvider.rerollWord(),
                                currentWord: wordProvider.currentWord,
                              );
                            },
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
