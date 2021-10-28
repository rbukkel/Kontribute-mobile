import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': {
          'language': 'Language',
          'home': 'Home',
        },
        'ar': {
          'language': 'لغة',
          'home': 'الصفحة الرئيسية',
        },
      };
}