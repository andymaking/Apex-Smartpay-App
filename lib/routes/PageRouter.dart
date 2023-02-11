// import 'package:Smartpay/data/services/navigation_service.dart';
// import 'package:Smartpay/routes/locator.dart';
// import 'package:flutter/material.dart';
//
// class PageRouter {
//   static final _navigation = getIt<NavigationService>();
//
//   static Future<void> pushNamed(String routeName, {dynamic args}) async =>
//       await _navigation.navigateTo(routeName, arguments: args);
//
//   static Future<void> pushWidget(Widget view, {dynamic args}) async =>
//       await _navigation.navigateToView(view);
//
//   static bool pop() => _navigation.back();
//
//   static void popToRoot() => _navigation.popUntil((route) => route.isFirst);
//
//   static Future<void> pushReplacement(String routeName, {dynamic args}) async =>
//       await _navigation.clearStackAndShow(routeName, arguments: args);
// }
