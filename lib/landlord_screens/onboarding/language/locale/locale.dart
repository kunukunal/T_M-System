import 'package:get/get.dart';
import 'package:tanent_management/landlord_screens/onboarding/language/locale/en_US.dart';
import 'package:tanent_management/landlord_screens/onboarding/language/locale/hi_IN.dart';

class LocaleFile extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'hi_IN': hi,
      };
}
