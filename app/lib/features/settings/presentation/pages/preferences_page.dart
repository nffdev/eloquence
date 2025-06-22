import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return Text(
              AppTranslations.translate('preferences', languageProvider.currentLanguage)
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          
          // Theme section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('appearance', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            ),
          ),
          
          // Theme toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SwitchListTile(
                title: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, _) {
                    return Text(
                      AppTranslations.translate('dark_theme', languageProvider.currentLanguage),
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  },
                ),
                subtitle: Consumer<LanguageProvider>(
                  builder: (context, languageProvider, _) {
                    return Text(
                      themeProvider.isDarkMode 
                          ? AppTranslations.translate('enabled', languageProvider.currentLanguage) 
                          : AppTranslations.translate('disabled', languageProvider.currentLanguage),
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),
                value: themeProvider.isDarkMode,
                onChanged: (_) {
                  themeProvider.toggleTheme();
                },
                secondary: Icon(
                  themeProvider.isDarkMode 
                      ? Icons.dark_mode 
                      : Icons.light_mode,
                ),
              );
            },
          ),
          
          const Divider(),
          
          // Language section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('language', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            ),
          ),
          
          // Language selector
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, _) {
              return ListTile(
                title: Text(
                  languageProvider.currentLanguage == AppLanguage.french ? 'Français' : 'English (US)',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  languageProvider.currentLanguage == AppLanguage.french ? 'FR' : 'EN-US',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: PopupMenuButton<AppLanguage>(
                  icon: const Icon(Icons.arrow_drop_down),
                  onSelected: (AppLanguage language) {
                    languageProvider.setLanguage(language);
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<AppLanguage>>[
                    PopupMenuItem<AppLanguage>(
                      value: AppLanguage.french,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 15,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(color: const Color(0xFF0055A4)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(color: Colors.white),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(color: const Color(0xFFEF4135)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('Français'),
                          if (languageProvider.currentLanguage == AppLanguage.french)
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.check, size: 16),
                            ),
                        ],
                      ),
                    ),
                    PopupMenuItem<AppLanguage>(
                      value: AppLanguage.english,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 15,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(2),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/us_flag.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text('English (US)'),
                          if (languageProvider.currentLanguage == AppLanguage.english)
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.check, size: 16),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}