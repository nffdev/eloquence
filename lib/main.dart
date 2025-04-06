import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/word_of_the_day/application/word_provider.dart';
import 'features/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WordProvider()),
    ],
    child: const EloquenceApp(),
  ));
}

class EloquenceApp extends StatelessWidget {
  const EloquenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Éloquence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashPage(),
    );
  }
}
