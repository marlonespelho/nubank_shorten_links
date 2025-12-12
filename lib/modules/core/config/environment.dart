import 'config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String production = 'PRODUCTION';
  static const String development = 'DEVELOPMENT';

  BaseConfig config = DevelopmentConfig();

  bool get isProduction => const String.fromEnvironment('ENVIRONMENT', defaultValue: 'DEVELOPMENT') == production;

  void initConfig() {
    config = _getConfig(isProduction);
  }

  BaseConfig _getConfig(bool prod) => prod ? ProductionConfig() : DevelopmentConfig();
}
