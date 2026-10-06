import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Centers its child and limits how wide it can grow.
class CenteredContent extends StatelessWidget {
  const CenteredContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
        child: child,
      ),
    );
  }
}