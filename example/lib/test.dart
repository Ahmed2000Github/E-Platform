import 'package:flutter/material.dart';
import 'package:intl/locale.dart';

class I18n {
  final Locale _locale;

  I18n(this._locale);

  static I18n of(BuildContext context) {
    // this returned null all time.
    return Localizations.of<I18n>(context, I18n);
  }

  String get test => "some translation";
}
