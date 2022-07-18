import 'package:flutter/material.dart';
import 'app_localization.dart';

String? getTranslated(String key, BuildContext context) {
  return AppLocalizations.of(context)?.translate(key);
}