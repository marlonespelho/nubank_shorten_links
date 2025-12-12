abstract class BaseConfig {
  String get apiBaseUrl;
}

class DevelopmentConfig extends BaseConfig {
  @override
  String get apiBaseUrl =>
      const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://url-shortener-server.onrender.com/api/');
}

class ProductionConfig extends BaseConfig {
  @override
  String get apiBaseUrl => const String.fromEnvironment('API_BASE_URL');
}
