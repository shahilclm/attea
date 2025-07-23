enum Flavor { debug, production, release, testing }



class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String? baseUrl;

  const FlavorConfig({
    required this.flavor,
    required this.name,
    this.baseUrl,
  });

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig is not initialized');
    }
    return _instance!;
  }

  static void initialize(FlavorConfig config) {
    _instance = config;
  }
}