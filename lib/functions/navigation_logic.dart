// !Navigate back three pages
import 'package:flutter/material.dart';
//TODO: import 'package:waya/screens/homepage.dart';

void navigateBackThreePages(BuildContext context) {
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
    // TODO: await Future.delayed(const Duration(seconds: 2), () {
    //   fetchHomepageNotifier.value = true;
    // });
  }
}
