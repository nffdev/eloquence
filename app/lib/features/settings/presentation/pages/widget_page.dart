import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../word_of_the_day/application/widget_service.dart';

class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return Text(
              AppTranslations.translate('widget_management', languageProvider.currentLanguage),
              style: const TextStyle(color: Colors.black),
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.widgets,
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppTranslations.translate('widget_preview', languageProvider.currentLanguage),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<ThemeProvider>(
                                builder: (context, themeProvider, _) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/logo-dark.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppTranslations.translate('app_name', languageProvider.currentLanguage),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                AppTranslations.translate('word_of_the_day', languageProvider.currentLanguage),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.palette,
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppTranslations.translate('appearance', languageProvider.currentLanguage),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, _) {
                            return Row(
                              children: [
                                Expanded(
                                  child: _buildThemeOption(
                                    context,
                                    languageProvider,
                                    AppTranslations.translate('light_theme', languageProvider.currentLanguage),
                                    Icons.light_mode,
                                    false,
                                    !themeProvider.isDarkMode,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildThemeOption(
                                    context,
                                    languageProvider,
                                    AppTranslations.translate('dark_theme', languageProvider.currentLanguage),
                                    Icons.dark_mode,
                                    true,
                                    themeProvider.isDarkMode,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Instructions section
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppTranslations.translate('how_to_add_widget', languageProvider.currentLanguage),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppTranslations.translate('widget_instructions', languageProvider.currentLanguage),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInstructionStep(
                          context,
                          '1',
                          AppTranslations.translate('long_press_home', languageProvider.currentLanguage),
                          Icons.touch_app,
                        ),
                        const SizedBox(height: 12),
                        _buildInstructionStep(
                          context,
                          '2',
                          AppTranslations.translate('tap_plus_icon', languageProvider.currentLanguage),
                          Icons.add_circle_outline,
                        ),
                        const SizedBox(height: 12),
                        _buildInstructionStep(
                          context,
                          '3',
                          AppTranslations.translate('search_eloquence', languageProvider.currentLanguage),
                          Icons.search,
                        ),
                        const SizedBox(height: 12),
                        _buildInstructionStep(
                          context,
                          '4',
                          AppTranslations.translate('select_widget_size', languageProvider.currentLanguage),
                          Icons.crop_free,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildInstructionStep(BuildContext context, String number, String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildThemeOption(
    BuildContext context,
    LanguageProvider languageProvider,
    String title,
    IconData icon,
    bool isDarkTheme,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () async {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
        if (isDarkTheme != themeProvider.isDarkMode) {
          await themeProvider.toggleTheme();
          await WidgetService.updateTheme(isDarkTheme);
          
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isDarkTheme 
                    ? 'Thème sombre appliqué au widget'
                    : 'Thème clair appliqué au widget',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.black.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.black.withOpacity(0.6),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.black.withOpacity(0.6),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}