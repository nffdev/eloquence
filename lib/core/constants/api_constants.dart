class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8080';
  static const String wordOfTheDayEndpoint = '/api/words/today';
  static const String wordOfTheDayUrl = '$baseUrl$wordOfTheDayEndpoint';
  static const int apiTimeoutSeconds = 5;
}
