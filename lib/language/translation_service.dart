// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US.dart';
import 'hi_IN.dart';
import 'ml_IN.dart';
import 'mr_IN.dart';

class LocalizationService extends Translations {
  // here we need to add our default language
  static final locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('hi', 'IN');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'Hindi', 'Malayalam', 'Marathi'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('ml', 'IN'),
    Locale('mr', 'IN')
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': en_US, 'hi_IN': hi_IN, 'ml_IN': ml_IN, 'mr_IN': mr_IN};

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
