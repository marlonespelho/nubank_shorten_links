abstract class BaseConfig {
  String get apiBaseUrl;
}

class DevelopmentConfig extends BaseConfig {
  @override
  String get apiBaseUrl =>
      String.fromEnvironment('API_BASE_URL', defaultValue: '');
}

class ProductionConfig extends BaseConfig {
  @override
  String get apiBaseUrl =>
      String.fromEnvironment('API_BASE_URL', defaultValue: '');
}
