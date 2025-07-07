class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8080'; // https://api.eloquence.social
  static const String wordOfTheDayEndpoint = '/api/words/today'; // /words/today
  static const String wordOfTheDayUrl = '$baseUrl$wordOfTheDayEndpoint';
  static const int apiTimeoutSeconds = 5;
}
