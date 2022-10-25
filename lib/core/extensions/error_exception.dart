class FetchErrorException implements Exception {
  final String errorMessage;

  FetchErrorException({required this.errorMessage});
}