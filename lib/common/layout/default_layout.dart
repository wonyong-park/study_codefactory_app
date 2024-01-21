import 'package:flutter/material.dart';

/// 모든 View에 공통적으로 적용하려고 할 때
class DefaultLayout extends StatelessWidget {
  final Widget child;

  const DefaultLayout({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }
}
