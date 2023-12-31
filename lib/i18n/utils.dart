// GENERATED CODE - DO NOT MODIFY BY HAND

/// You can learn more about `flutter_translation_sheet` in the Wiki:
/// https://github.com/roipeker/flutter_translation_sheet/

import 'i18n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

// **************************************************************************
// Fts main utils class
// **************************************************************************

class Fts {
  /// List of known right to left languages.
  static const List<String> _rtlLanguages = <String>[
    'ar',
    'fa',
    'he',
    'ps',
    'ur'
  ];

  /// Delegate used for [MaterialApp]
  static const FtsDelegate delegate = FtsDelegate();

  static WidgetsBinding get _binding =>
      WidgetsFlutterBinding.ensureInitialized();

  static Locale? _locale;

  static late Locale fallbackLocale;

  /// Notifies for system locale changes.
  static final onSystemLocaleChanged = ValueNotifier(
    deviceLocale,
  );

  /// You can wrap the [MaterialApp] in a [ListenableBuilder] to notify about changes
  /// when using the setter for `Fts.locale`.
  static final onLocaleChanged = ValueNotifier(
    AppLocales.supportedLocales.first,
  );

  /// current TextDirection
  static TextDirection get textDirection => _textDirection;

  static Locale get locale {
    return _locale ?? AppLocales.supportedLocales.first;
  }

  static var _textDirection = TextDirection.ltr;

  /// Notifies globally about a manual Locale change.
  static set locale(Locale value) {
    if (!AppLocales.supportedLocales.contains(value)) {
      Locale? langLocale;
      for (var supportedLocale in AppLocales.supportedLocales) {
        if (supportedLocale.languageCode == value.languageCode) {
          langLocale = supportedLocale;
        }
      }
      if (langLocale != null) {
        if (kDebugMode) {
          print(
              'Full locale "$value" not found. But a matching language "$langLocale" was found. Using it');
        }
        value = langLocale;
      } else {
        if (kDebugMode) {
          print('No supported locale found for "$value"');
        }
        return;
      }
    }
    _locale = value;
    _textDirection = _rtlLanguages.contains(value.languageCode)
        ? TextDirection.rtl
        : TextDirection.ltr;
    onLocaleChanged.value = _locale!;

    _notifyUpdate();
  }

  static void _notifyUpdate() {
    _binding.addPostFrameCallback((timeStamp) {
      _binding.performReassemble();
    });
  }

  static void init({
    Locale? locale,
    Locale? fallbackLocale,
  }) {
    final originalCallback = _binding.platformDispatcher.onLocaleChanged;
    _binding.platformDispatcher.onLocaleChanged = () {
      originalCallback?.call();
      onSystemLocaleChanged.value = _binding.platformDispatcher.locale;
    };

    Fts.fallbackLocale = fallbackLocale ?? AppLocales.supportedLocales.first;

    locale ??= deviceLocale;
    Fts.locale = locale;
  }

  static Locale get deviceLocale => _binding.platformDispatcher.locale;
}

/// Use `MaterialApp.localizationsDelegates: const [FtsDelegate()],`
/// Basic delegate for TextDirection
class _FtsLocalization extends DefaultWidgetsLocalizations {
  const _FtsLocalization();

  @override
  TextDirection get textDirection => Fts.textDirection;
}

class FtsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  final localization = const _FtsLocalization();

  const FtsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) async => localization;

  @override
  bool shouldReload(FtsDelegate old) => false;
}
