import 'package:shared_preferences/shared_preferences.dart';

class UserSetting {
  static const _keyName  = 'Name';
  static const _keyEmoji = 'Emoji';
  static const defaultName  = '名無しの権兵衛';
  static const defaultEmoji = '🙂';

  /// --- Name ---
  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }
  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName) ?? defaultName;
  }

  /// --- Emoji ---
  static Future<void> setEmoji(String emoji) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmoji, emoji);
  }
  static Future<String> getEmoji() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmoji) ?? defaultEmoji;
  }
}