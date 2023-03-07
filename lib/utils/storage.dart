import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// kv离线存储
class Storage {
  /// 单例
  Storage._init();
  static final Storage _instance = Storage._init();
  factory Storage() => _instance;

  late final SharedPreferences _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setJson(String key, Object value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  List<String> getList(String key, {List<String>? defaultValue}) {
    return _prefs.getStringList(key) ?? (defaultValue ?? <String>[]);
  }

  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }
}
