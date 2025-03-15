enum HrInsightsFlavor { dev, qa, prod }

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

  static void init(HrInsightsFlavor flavor) {
    switch (flavor) {
      case HrInsightsFlavor.dev:
        _currentConfig = DevConfig(
          baseUrl: 'https://dev-api.masdr.sa/hr-insights/v1',
          apiKey: 'm4dyPShoDR4pn1QscHVHkIOVQHKOfVn9',
        );
        break;
      case HrInsightsFlavor.qa:
        _currentConfig = QaConfig(
          baseUrl: 'https://qa.example.com',
          apiKey: 'qa-api-key',
        );
        break;
      case HrInsightsFlavor.prod:
        _currentConfig = ProdConfig(
          baseUrl: 'https://prod.example.com',
          apiKey: 'prod-api-key',
        );
        break;
    }
  }

  static BaseConfig get config {
    if (_currentConfig == null) {
      // throw Exception(
      //     'FlavorConfig is not initialized. Please call init() first.');
      _currentConfig = DevConfig(
        // baseUrl: 'https://dev-api.masdr.sa',
        // apiKey: 'm4dyPShoDR4pn1QscHVHkIOVQHKOfVn9',
        baseUrl: 'http://10.4.192.181:9003',
        apiKey: 'wpUvU6l4mwb7v5yvEOopBmAMZTxhzqgG',
      );
    }
    return _currentConfig!;
  }
}
