class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8080'; // https://api.eloquence.social
  static const String wordOfTheDayEndpoint = '/words/today'; // /words/today
  static const String wordOfTheDayUrl = '$baseUrl$wordOfTheDayEndpoint';
  
  static const String allWordsEndpoint = '/words'; 
  static const String allWordsUrl = '$baseUrl$allWordsEndpoint';
  
  static const String wordByNameEndpoint = '/words/'; 
  static String getWordByNameUrl(String name) => '$baseUrl$wordByNameEndpoint$name';
  
  static const int apiTimeoutSeconds = 5;
}
