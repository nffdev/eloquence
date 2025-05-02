import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        return PopupMenuButton<AppLanguage>(
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (AppLanguage language) {
            languageProvider.setLanguage(language);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<AppLanguage>>[
            _buildLanguageItem(
              context,
              AppLanguage.french,
              'FR',
              languageProvider.currentLanguage == AppLanguage.french,
            ),
            _buildLanguageItem(
              context,
              AppLanguage.english,
              'EN-US',
              languageProvider.currentLanguage == AppLanguage.english,
            ),
          ],
          child: Row(
            children: [
              _buildFlag(languageProvider.flagCode),
              const SizedBox(width: 4),
              Text(
                languageProvider.languageDisplayName,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                size: 16,
              ),
            ],
          ),
        );
      },
    );
  }

  PopupMenuItem<AppLanguage> _buildLanguageItem(
    BuildContext context,
    AppLanguage language,
    String displayName,
    bool isSelected,
  ) {
    final flagCode = language == AppLanguage.french ? 'FR' : 'US';
    
    return PopupMenuItem<AppLanguage>(
      value: language,
      child: Row(
        children: [
          _buildFlag(flagCode),
          const SizedBox(width: 8),
          Text(
            displayName,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.check,
              size: 16,
              color: Colors.green,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFlag(String countryCode) {
    return Builder(
      builder: (context) {
        final borderColor = Theme.of(context).brightness == Brightness.dark 
            ? Colors.white70 
            : Colors.black45;
        
        return Container(
          width: 20,
          height: 15,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
          child: _getFlagContent(countryCode),
        );
      },
    );
  }

  Widget _getFlagContent(String countryCode) {
    if (countryCode == 'FR') {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fr_flag.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (countryCode == 'US') {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/us_flag.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    
    return Container();
  }
}
