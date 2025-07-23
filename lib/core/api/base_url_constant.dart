


import '../../flavors/flutter_flavors.dart';

enum ApiType { base, coffee, baseUrl, product }

class BaseUrlConstant {
  static final Map<Flavor, Map<ApiType, String>> _urls = {
    Flavor.debug: {
      ApiType.base: 'https://debug.example.com/base',
      ApiType.coffee: 'https://debug.example.com/coffee',
      ApiType.baseUrl: 'https://debug.example.com/baseurl',
      ApiType.product: 'https://debug.example.com/product',
    },
    Flavor.production: {
      ApiType.base: 'https://prod.example.com/base',
      ApiType.coffee: 'https://prod.example.com/coffee',
      ApiType.baseUrl: 'https://prod.example.com/baseurl',
      ApiType.product: 'https://prod.example.com/product',
    },
    Flavor.release: {
      ApiType.base: 'https://release.example.com/base',
      ApiType.coffee: 'https://release.example.com/coffee',
      ApiType.baseUrl: 'https://release.example.com/baseurl',
      ApiType.product: 'https://release.example.com/product',
    },
    Flavor.testing: {
      ApiType.base: 'https://testing.example.com/base',
      ApiType.coffee: 'https://testing.example.com/coffee',
      ApiType.baseUrl: 'https://testing.example.com/baseurl',
      ApiType.product: 'https://testing.example.com/product',
    },
  };

  static String getBaseUrl(ApiType type) {
    final flavor = FlavorConfig.instance.flavor;
    final flavorUrls = _urls[flavor];

    if (flavorUrls == null || !flavorUrls.containsKey(type)) {
      throw Exception('Base URL not defined for $type in $flavor');
    }

    return flavorUrls[type]!;
  }
}
