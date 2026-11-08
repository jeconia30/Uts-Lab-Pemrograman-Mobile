import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Membatasi lebar konten dan memberi padding responsif.
/// Di HP memenuhi layar, di tablet/web tetap di tengah dan proporsional.
class ContentFrame extends StatelessWidget {
  const ContentFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.sp(22)),
          child: child,
        ),
      ),
    );
  }
}