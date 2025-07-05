import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/localization/language_provider.dart';
import '../../../../core/localization/app_translations.dart';
import 'preferences_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return Text(
              AppTranslations.translate('settings', languageProvider.currentLanguage)
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
          
          // Preferences section
          ListTile(
            title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('preferences', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              },
            ),
            subtitle: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('preferences_subtitle', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PreferencesPage(),
                ),
              );
            },
          ),
          
          const Divider(),
          
          // App info section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('about', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            ),
          ),
          
          ListTile(
            title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('version', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              },
            ),
            subtitle: Text(
              '1.0.0',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: const Icon(Icons.info_outline),
          ),
          
          ListTile(
            title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('rate_app', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              },
            ),
            subtitle: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('rate_app_subtitle', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
            leading: const Icon(Icons.star_outline),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              final Uri url = Uri.parse('https://apps.apple.com/fr/app/eloquence/id6746582572');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to open link'),
                    ),
                  );
                }
              }
            },
          ),

          ListTile(
            title: Consumer<LanguageProvider>(
              builder: (context, languageProvider, _) {
                return Text(
                  AppTranslations.translate('developer', languageProvider.currentLanguage),
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              },
            ),
            subtitle: Text(
              'nffdev',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: const Icon(Icons.code),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              final Uri url = Uri.parse('https://github.com/nffdev/Eloquence');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to open link'),
                    ),
                  );
                }
              }
            },
          ),
          

        ],
      ),
    );
  }
}
