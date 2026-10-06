import 'package:flutter/material.dart';

import 'breakpoints.dart';

/// Shows [compact] on narrow screens (phone portrait)
/// and [wide] on wide screens (landscape, tablet).
class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({super.key, required this.compact, required this.wide});

  final Widget compact;
  final Widget wide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth >= Breakpoints.tablet ? wide : compact;
      },
    );
  }
}
