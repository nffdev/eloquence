import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/theme/theme_provider.dart';

class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return Text(
              AppTranslations.translate('widget_management', languageProvider.currentLanguage)
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.widgets,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppTranslations.translate('widget_preview', languageProvider.currentLanguage),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor.withOpacity(0.1),
                                Theme.of(context).primaryColor.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
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
                                        themeProvider.isDarkMode 
                                            ? 'assets/images/logo-dark.png'
                                            : 'assets/images/logo-light.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppTranslations.translate('app_name', languageProvider.currentLanguage),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                AppTranslations.translate('word_of_the_day', languageProvider.currentLanguage),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Instructions section
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppTranslations.translate('how_to_add_widget', languageProvider.currentLanguage),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppTranslations.translate('widget_instructions', languageProvider.currentLanguage),
                          style: Theme.of(context).textTheme.bodyMedium,
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
            color: Theme.of(context).primaryColor,
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
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
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