// Basic Flutter widget smoke test.
import 'package:flutter_test/flutter_test.dart';
import 'package:save_insights_code/main.dart';
import 'package:save_insights_code/core/theme/theme_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final themeProvider = ThemeProvider();
    await tester.pumpWidget(SaveInsightApp(themeProvider: themeProvider));
    expect(find.byType(SaveInsightApp), findsOneWidget);
  });
}
