import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/main_shell.dart';

final ThemeProvider _themeProvider = ThemeProvider();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SaveInsightApp(themeProvider: _themeProvider));
}

class SaveInsightApp extends StatelessWidget {
  final ThemeProvider themeProvider;
  const SaveInsightApp({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      provider: themeProvider,
      child: AnimatedBuilder(
        animation: themeProvider,
        builder: (context, _) {
          // Resolve effective brightness so we can set system chrome
          final isDark = _resolveIsDark(context, themeProvider.themeMode);

          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            systemNavigationBarColor:
                isDark ? const Color(0xFF1C1930) : const Color(0xFFEDEBFA),
            systemNavigationBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
          ));

          return MaterialApp(
            title: 'SaveInsight',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme.copyWith(
              textTheme: AppTheme.lightTheme.textTheme.apply(
                fontFamily: 'AppFont',
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              textTheme: AppTheme.darkTheme.textTheme.apply(
                fontFamily: 'AppFont',
              ),
            ),
            themeMode: themeProvider.themeMode,
            routes: {
              '/': (context) => const SplashScreen(),
              '/home': (context) => const MainShell(),
            },
          );
        },
      ),
    );
  }

  bool _resolveIsDark(BuildContext context, ThemeMode mode) {
    if (mode == ThemeMode.dark) return true;
    if (mode == ThemeMode.light) return false;
    // ThemeMode.system — check platform brightness
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }
}
