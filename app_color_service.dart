import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dsfh_flutter_v3/core/constants/app_color_const.dart';
import 'package:dsfh_flutter_v3/core/constants/endpoints.dart';
import 'package:dsfh_flutter_v3/core/network/dio_client.dart';
import 'package:dsfh_flutter_v3/core/services/secure_storage_service.dart';
import 'package:dsfh_flutter_v3/core/styles/app_colors.dart';

/// App Color Service
/// Loads and applies brand colors dynamically from server or cache
class AppColorService {
  static final _dio = GetIt.I<DioClient>();
  static final _storage = GetIt.I<SecureStorageService>();

  /// Loads color JSON from server → cache → [_apply]
  static Future<bool> init() async {
    // Try fetching from server
    try {
      debugPrint("🌐 Fetching color config from ${Constants.colorUrl}");

      final response = await _dio.request(
        Constants.colorUrl,
        method: HttpMethod.get,
      );

      // Dio already decodes JSON if response is application/json
      final Map<String, dynamic> data = response is Map<String, dynamic>
          ? response
          : Map<String, dynamic>.from(response);

      debugPrint("✅ Color config loaded from server: $data");

      // Store as string in secure storage
      await _storage.write(Constants.colorSessionKey, jsonEncode(data));

      // Apply to runtime colors
      _apply(data);
      return true;
    } on DioException catch (e) {
      debugPrint("❌ Network error loading colors: ${e.message}");
    } on FormatException catch (e) {
      debugPrint("❌ JSON parse error in color file: ${e.message}");
    } catch (e) {
      debugPrint("❌ Unknown error loading colors: $e");
    }

    // Fallback: try cached JSON
    try {
      final cached = await _storage.read(Constants.colorSessionKey);
      if (cached != null) {
        final data = jsonDecode(cached) as Map<String, dynamic>;
        _apply(data);
        debugPrint("📦 Using cached color config");
        return true;
      }
    } catch (e) {
      debugPrint("❌ Error using cached color config: $e");
    }

    debugPrint("⚠️ No color config loaded. Falling back to defaults (if any)");
    return false;
  }

  /// Apply values to runtime [AppColors]
  static void _apply(Map<String, dynamic> json) {
    AppColors.primary = _hexToColor(json[AppColorConst.primary]);
    AppColors.secondary = _hexToColor(json[AppColorConst.secondary]);
    AppColors.neutralDark = _hexToColor(json[AppColorConst.neutralDark]);
    AppColors.neutralLight = _hexToColor(json[AppColorConst.neutralLight]);
    AppColors.textPrimary = _hexToColor(json[AppColorConst.textPrimary]);
    AppColors.textOnPrimary = _hexToColor(json[AppColorConst.textOnPrimary]);
    AppColors.backgroundLight =
        _hexToColor(json[AppColorConst.backgroundLight]);
    AppColors.backgroundDark = _hexToColor(json[AppColorConst.backgroundDark]);
  }

  static Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    return Color(int.parse('0xff$hex'));
  }
}
