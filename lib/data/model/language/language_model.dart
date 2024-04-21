class MyLanguageModel {
  String languageName;
  String? imageUrl;
  String languageCode;
  String countryCode;

  MyLanguageModel({
    required this.languageName,
    required this.countryCode,
    required this.languageCode,
    this.imageUrl,
  });
}
