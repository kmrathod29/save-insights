import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight theme mode controller with SharedPreferences persistence.
/// Consumed via the inherited widget below.
class ThemeProvider extends ChangeNotifier {
  static const _key = 'theme_mode'; // 0 = system, 1 = light, 2 = dark

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  /// Load persisted value. Call once before runApp.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getInt(_key); // null on first launch
    if (stored != null) {
      _themeMode = _fromInt(stored);
    }
    // No notifyListeners here — widget tree isn't built yet.
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      _persist(mode);
    }
  }

  Future<void> _persist(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, _toInt(mode));
  }

  static int _toInt(ThemeMode m) {
    switch (m) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
    }
  }

  static ThemeMode _fromInt(int v) {
    switch (v) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

/// Inherited widget that makes ThemeProvider available to the entire tree.
class ThemeScope extends InheritedNotifier<ThemeProvider> {
  const ThemeScope({
    super.key,
    required ThemeProvider provider,
    required super.child,
  }) : super(notifier: provider);

  static ThemeProvider of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'ThemeScope not found in widget tree');
    return scope!.notifier!;
  }
}
