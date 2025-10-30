import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Push route with optional arguments
  static Future<dynamic>? pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  /// Replace current route
  static Future<dynamic>? pushReplacementNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pop current route and optionally return a result
  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  /// Push a route and wait for result
  static Future<T?> pushForResult<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Go back to first route
  static void popUntilRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
