import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const JAP_LOCALE = 'ja';
const EN_LOCALE = 'en';
const FR_LOCALE = 'fr';
const DEFAULT_LOCALE = EN_LOCALE;
const APP_NAME = "Jpec's training";

const SUPPORTED_LOCALES = [EN_LOCALE, FR_LOCALE, JAP_LOCALE];

class LocalizationWidget {
  LocalizationWidget(this.locale);

  final Locale locale;

  static LocalizationWidget of(BuildContext context) {
    return Localizations.of<LocalizationWidget>(context, LocalizationWidget);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    EN_LOCALE: {
      'home': 'Home',
    },
    FR_LOCALE: {
      'home': 'Accueil'
    },
    JAP_LOCALE: {
      'home': 'ie',
    },
  };

  String getLocalizeValue(String key) {
    if (!_localizedValues[locale.languageCode].containsKey(key)) {
      if (!_localizedValues[DEFAULT_LOCALE].containsKey(key)) {
        return key;
      }
      return _localizedValues[DEFAULT_LOCALE][key];
    }
    return _localizedValues[locale.languageCode][key];
  }
}

class MyLocalizationsDelegate
    extends LocalizationsDelegate<LocalizationWidget> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      SUPPORTED_LOCALES.contains(locale.languageCode);

  @override
  Future<LocalizationWidget> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<LocalizationWidget>(LocalizationWidget(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}