import 'package:flutter/material.dart';

class NavigationService {
  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();
  static final NavigationService _instance = NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext getCurrentContext() {
    return _instance.navigatorKey.currentState!.context;
  }
}
