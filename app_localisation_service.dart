import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dsfh_flutter_v3/core/constants/endpoints.dart';
import 'package:dsfh_flutter_v3/core/di/service_locator.dart';
import 'package:dsfh_flutter_v3/core/network/dio_client.dart';
import 'package:dsfh_flutter_v3/core/services/secure_storage_service.dart';

/// App Localization Service
/// Loads translations (EN/AR) from server or cache and applies them at runtime.
class AppLocalizationService {
  static final _dio = getIt<DioClient>();
  static final _storage = getIt<SecureStorageService>();

  static Map<String, dynamic> _localizedValues = {};
  static String _currentLanguage = 'en'; // Default to English

  /// Get current language code
  static String get currentLanguage => _currentLanguage;

  /// Initialize translations
  /// - `languageCode`: optional override, otherwise uses stored or 'en'
  /// - Returns TRUE if translations loaded successfully
  static Future<bool> init([String? languageCode]) async {
    // Determine target language
    _currentLanguage = languageCode ??
        (await _storage.read(Constants.translationLanguageKey)) ??
        'en';

    final url = _currentLanguage == 'ar'
        ? Constants.translationArUrl
        : Constants.translationEngUrl;

    // ------------------------ TRY SERVER ------------------------
    try {
      debugPrint("🌐 Fetching translations from: $url");

      final response = await _dio.request(
        url,
        method: HttpMethod.get,
      );

      // Ensure we always have a JSON string to decode/store
      final String jsonString = response is String
          ? response
          : jsonEncode(response); // fallback if Dio parses to map

      // Save translation and language
      await _storage.write(Constants.translationSessionKey, jsonString);
      await _storage.write(Constants.translationLanguageKey, _currentLanguage);

      _localizedValues = jsonDecode(jsonString);
      debugPrint("✅ Translation loaded from server for [$_currentLanguage]");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ Network error loading translations: ${e.message}");
    } on FormatException catch (e) {
      debugPrint("❌ JSON parse error in translations: ${e.message}");
    } catch (e) {
      debugPrint("❌ Unknown error loading translations: $e");
    }

    // ------------------------ FALLBACK CACHE ------------------------
    try {
      final cached = await _storage.read(Constants.translationSessionKey);
      if (cached != null) {
        _localizedValues = jsonDecode(cached);
        debugPrint("📦 Fallback: translation loaded from cache");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Error using cached translation: $e");
    }

    debugPrint("⚠️ No translations loaded. Defaulting to English");
    return false;
  }

  /// Read nested json using dot notation e.g. tr("splash_screen.retry")
  static String tr(String key) {
    try {
      final parts = key.split('.');
      dynamic value = _localizedValues;
      for (final p in parts) {
        value = value[p];
      }
      return value?.toString() ?? key;
    } catch (e) {
      debugPrint("⚠️ Missing translation key → $key");
      return key;
    }
  }

  /// Change language at runtime
  static Future<void> setLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    await _storage.write(Constants.translationLanguageKey, _currentLanguage);
    await init(_currentLanguage); // reload translations
  }
}

extension LocalizationExtension on String {
  String get tr => AppLocalizationService.tr(this);
}