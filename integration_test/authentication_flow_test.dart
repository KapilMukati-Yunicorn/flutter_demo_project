
import 'package:bloc_project/core/keys/widget_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bloc_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Helper → Wait until a widget is found or timeout
  Future<void> pumpUntilFound(
      WidgetTester tester,
      Finder finder, {
        Duration timeout = const Duration(seconds: 10),
        Duration step = const Duration(milliseconds: 200),
      }) async {
    final endTime = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(endTime)) {
      await tester.pump(step);
      if (finder.evaluate().isNotEmpty) return;
    }
    throw Exception("Timeout waiting for ${finder.toString()}");
  }

  testWidgets('Authentication flow:splash → login → signup → login → navigate', (tester) async {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    print("🚀 Launching app...");
    app.main();
    await tester.pumpAndSettle();

    print("⏳ Waiting for splash → login screen...");
    await pumpUntilFound(tester, find.byKey(WidgetKeys.loginSignupButton));

    print("🔘 In login screen Tapping signup button...");
    await binding.traceAction(() async {
      await tester.tap(find.byKey(WidgetKeys.loginSignupButton));
      print("⏳ Waiting for signUp screen...");
      await pumpUntilFound(tester, find.byKey(WidgetKeys.signupNameField));

      print("✅ SignUp screen ready. Checking fields...");
      expect(find.byKey(WidgetKeys.signupNameField), findsOneWidget);
      expect(find.byKey(WidgetKeys.signupEmailField), findsOneWidget);
      expect(find.byKey(WidgetKeys.signupPasswordField), findsOneWidget);
      expect(find.byKey(WidgetKeys.signupCnfPasswordField), findsOneWidget);

      print("✍️ Entering signup fields...");
      await tester.enterText(find.byKey(WidgetKeys.signupNameField), 'arvind');
      await tester.enterText(find.byKey(WidgetKeys.signupEmailField), 'test@gmail.com');
      await tester.enterText(find.byKey(WidgetKeys.signupPasswordField), '123456');
      await tester.enterText(find.byKey(WidgetKeys.signupCnfPasswordField), '123456');

      print("⏳ Click on SignUp button...");
      await tester.tap(find.byKey(WidgetKeys.signupButton));
      await tester.pump();
      print("⏳ SignUp loading state...");
      expect(find.byKey(WidgetKeys.signupLoadingButton), findsOneWidget);

      // simulate async delay
      await tester.pump(const Duration(seconds: 3));
    }, reportKey: 'signup_flow_performance');

    print("✅ waiting login screen again after complete signup...");
    await pumpUntilFound(tester, find.byKey(WidgetKeys.loginEmailField));
    print("✅ Login screen ready. Checking fields...");
    expect(find.byKey(WidgetKeys.loginEmailField), findsOneWidget);
    expect(find.byKey(WidgetKeys.loginPasswordField), findsOneWidget);

    print("✍️ Entering credentials...");
    await tester.enterText(find.byKey(WidgetKeys.loginEmailField), 'test@gmail.com');
    await tester.enterText(find.byKey(WidgetKeys.loginPasswordField), '123456');

    print("🔘 Tapping login button...");
    await binding.traceAction(() async {
      await tester.tap(find.byKey(WidgetKeys.loginButton));
      await tester.pump();

      print("⏳ Checking loading state...");
      expect(find.byKey(WidgetKeys.loginLoading), findsOneWidget);

      // simulate async delay
      await tester.pump(const Duration(seconds: 3));
    }, reportKey: 'login_flow_performance');

    print("🎉 Verifying navigation to BottomNav...");
    await pumpUntilFound(tester, find.byKey(WidgetKeys.bottomNavBar));
    expect(find.byKey(WidgetKeys.bottomNavBar), findsOneWidget);

    print("✅ Test finished successfully!");
  });
}
