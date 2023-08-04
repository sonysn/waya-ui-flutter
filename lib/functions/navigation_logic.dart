// !Navigate back three pages
import 'package:flutter/material.dart';
import 'package:qunot/screens/homepage.dart';

void navigateBackThreePages(BuildContext context) async {
  // Get the current Navigator state
  NavigatorState navigatorState = Navigator.of(context);

  // Check if there are at least three pages in the navigation stack
  if (navigatorState.canPop()) {
    navigatorState.pop(); // Pop the current page
  }
  if (navigatorState.canPop()) {
    navigatorState.pop(); // Pop the previous page
  }
  if (navigatorState.canPop()) {
    navigatorState.pop(); // Pop the page before the previous page
    await Future.delayed(const Duration(seconds: 1), () {
      fetchHomepageNotifier.value = true;
    });
  }
}
