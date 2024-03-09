import 'package:flutter/material.dart';

class NoSplashScroll extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  const NoSplashScroll({super.key, this.padding, this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(behavior: MyBehavior(), child: child!);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}