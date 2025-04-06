import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Force portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system overlay style to match our black theme
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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
            letterSpacing: 1.0,
          ),
          bodyLarge: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white70,
            letterSpacing: 0.5,
            height: 1.5,
          ),
          bodyMedium: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white60,
            letterSpacing: 0.5,
            height: 1.5,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

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
    
    // Load today's word
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
      body: Consumer<WordProvider>(
        builder: (context, wordProvider, child) {
          if (wordProvider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Word type indicator
                    Text(
                      '(${wordProvider.currentWord.type})',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Word of the day
                    Text(
                      '${wordProvider.currentWord.word} :',
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    // Definition
                    Text(
                      wordProvider.currentWord.definition,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    // Example section
                    Text(
                      'Exemple :',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Example sentence
                    Text(
                      '"${wordProvider.currentWord.example}"',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    // Share and favorite buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share_outlined, color: Colors.white70),
                          onPressed: () {
                            // Share functionality would go here
                          },
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: Icon(
                            wordProvider.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                            color: wordProvider.isFavorite ? Colors.redAccent : Colors.white70,
                          ),
                          onPressed: () {
                            wordProvider.toggleFavorite();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.home_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                onPressed: () {
                  // Navigate to favorites
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  // Navigate to profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Word {
  final String word;
  final String type;
  final String definition;
  final String example;
  final String date;
  bool isFavorite;

  Word({
    required this.word,
    required this.type,
    required this.definition,
    required this.example,
    required this.date,
    this.isFavorite = false,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'],
      type: json['type'],
      definition: json['definition'],
      example: json['example'],
      date: json['date'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'type': type,
      'definition': definition,
      'example': example,
      'date': date,
      'isFavorite': isFavorite,
    };
  }
}

class WordProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  
  late Word _currentWord;
  Word get currentWord => _currentWord;
  
  final List<Word> _words = [
    Word(
      word: 'Éthéré',
      type: 'Adj',
      definition: 'D\'une beauté irréelle, presque céleste',
      example: 'Son regard était d\'une beauté éthérée, comme s\'il appartenait à un rêve.',
      date: '2023-04-06',
    ),
    Word(
      word: 'Sérendipité',
      type: 'Nom',
      definition: 'Le fait de découvrir quelque chose par hasard alors qu\'on cherchait autre chose',
      example: 'C\'est par sérendipité qu\'il a trouvé sa vocation en se perdant dans ce musée.',
      date: '2023-04-07',
    ),
    Word(
      word: 'Ineffable',
      type: 'Adj',
      definition: 'Qui ne peut être exprimé par des paroles tant c\'est intense',
      example: 'Face à ce paysage grandiose, il ressentit une joie ineffable.',
      date: '2023-04-08',
    ),
    Word(
      word: 'Acrimonie',
      type: 'Nom',
      definition: 'Aigreur, amertume qui se manifeste dans les paroles ou le comportement',
      example: 'Il a répondu avec acrimonie aux critiques formulées contre son projet.',
      date: '2023-04-09',
    ),
    Word(
      word: 'Quintessence',
      type: 'Nom',
      definition: 'Ce qu\'il y a de plus raffiné, de plus pur, l\'essence parfaite d\'une chose',
      example: 'Ce plat représente la quintessence de la cuisine française traditionnelle.',
      date: '2023-04-10',
    ),
  ];
  
  Future<void> loadTodaysWord() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      // Check if we have a saved word for today
      final savedWordJson = prefs.getString('word_$today');
      
      if (savedWordJson != null) {
        // We have a saved word for today
        final wordData = json.decode(savedWordJson);
        _currentWord = Word.fromJson(wordData);
        _isFavorite = _currentWord.isFavorite;
      } else {
        // No saved word, select one from our list
        // In a real app, you might want to ensure you don't repeat words too soon
        final random = DateTime.now().day % _words.length;
        _currentWord = _words[random];
        
        // Save today's word
        await prefs.setString('word_$today', json.encode(_currentWord.toJson()));
      }
    } catch (e) {
      // Fallback to a default word if there's an error
      _currentWord = _words[0];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void toggleFavorite() async {
    _isFavorite = !_isFavorite;
    _currentWord.isFavorite = _isFavorite;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      // Update the saved word
      await prefs.setString('word_$today', json.encode(_currentWord.toJson()));
      
      // Also update favorites list
      List<String> favorites = prefs.getStringList('favorites') ?? [];
      
      if (_isFavorite) {
        if (!favorites.contains(_currentWord.word)) {
          favorites.add(_currentWord.word);
        }
      } else {
        favorites.removeWhere((word) => word == _currentWord.word);
      }
      
      await prefs.setStringList('favorites', favorites);
    } catch (e) {
      // Handle error
    }
    
    notifyListeners();
  }
}
