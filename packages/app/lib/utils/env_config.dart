enum AbshereAppFlavor { dev, qa, prod }

abstract class BaseConfig {
  String baseUrl;
  String apiKey;

  BaseConfig({required this.apiKey, required this.baseUrl});
}

class DevConfig extends BaseConfig {
  DevConfig({required super.baseUrl, required super.apiKey});
}

class QaConfig extends BaseConfig {
  QaConfig({required super.baseUrl, required super.apiKey});
}

class ProdConfig extends BaseConfig {
  ProdConfig({required super.baseUrl, required super.apiKey});
}

class FlavorConfig {
  static BaseConfig? _currentConfig;

  static void init(AbshereAppFlavor flavor) {
    switch (flavor) {
      case AbshereAppFlavor.dev:
        _currentConfig = DevConfig(
          baseUrl: 'https://dev-api.masdr.sa/hr-insights/v1',
          apiKey: 'm4dyPShoDR4pn1QscHVHkIOVQHKOfVn9',
        );
        break;
      case AbshereAppFlavor.qa:
        _currentConfig = QaConfig(
          baseUrl: 'https://qa.example.com',
          apiKey: 'qa-api-key',
        );
        break;
      case AbshereAppFlavor.prod:
        _currentConfig = ProdConfig(
          baseUrl: 'https://prod.example.com',
          apiKey: 'prod-api-key',
        );
        break;
    }
  }

  static BaseConfig get config {
    if (_currentConfig == null) {
      throw Exception(
          'FlavorConfig is not initialized. Please call init() first.');
    }
    return _currentConfig!;
  }
}
