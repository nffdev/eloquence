import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
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
            child: Text(
              'Apparence',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          
          // Theme toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SwitchListTile(
                title: Text(
                  'Thème sombre',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  themeProvider.isDarkMode 
                      ? 'Activé' 
                      : 'Désactivé',
                  style: Theme.of(context).textTheme.bodyMedium,
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
          
          // App info section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'À propos',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          
          ListTile(
            title: Text(
              'Version',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              '1.0.0',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: const Icon(Icons.info_outline),
          ),
          
          ListTile(
            title: Text(
              'Développeur',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              'nffdev',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: const Icon(Icons.code),
          ),
        ],
      ),
    );
  }
}
