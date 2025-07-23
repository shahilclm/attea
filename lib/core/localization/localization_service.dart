class LocalizationService {
  final String locale;

  LocalizationService(this.locale);

  static final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'hello': 'Hello',
      'submit': 'Submit',
    },
    'ml': {
      'hello': 'ഹലോ',
      'submit': 'സമർപ്പിക്കുക',
    },
  };

  String translate(String key) => _localizedStrings[locale]?[key] ?? key;
}
