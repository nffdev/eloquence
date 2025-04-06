import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/word_of_the_day/application/word_provider.dart';
import 'features/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WordProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const EloquenceApp(),
  ));
}

class EloquenceApp extends StatelessWidget {
  const EloquenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      statusBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
    ));
    
    return MaterialApp(
      title: 'Éloquence',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const SplashPage(),
    );
  }
}
