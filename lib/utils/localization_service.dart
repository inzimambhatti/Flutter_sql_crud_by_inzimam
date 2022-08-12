import 'package:flutter/material.dart';
import 'package:flutter_sql_crud_by_inzimam/utils/en_us.dart';
import 'package:flutter_sql_crud_by_inzimam/utils/fa_AF.dart';
import 'package:get/get.dart';


class LocalizationService extends Translations {
  static final locale = Locale("en", "US");

  static final fallBackLocale = Locale("en", "US");

  static final langs = ['فارسی', 'English'];

  static final locales = [Locale("fa", "AF"), Locale("en", "US")];
  var selectedLang = langs.first.obs;

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'fa_AF': faAF,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    selectedLang.value = lang;
    Get.updateLocale(locale!);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
