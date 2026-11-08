import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class ProgressHeader extends StatelessWidget {
  const ProgressHeader({super.key, required this.current, required this.total});

  /// Nomor soal saat ini (mulai dari 1).
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SOAL $current',
              style: TextStyle(
                fontSize: context.sp(13),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: cs.primary,
              ),
            ),
            Text(
              'dari $total',
              style: TextStyle(
                fontSize: context.sp(13),
                color: cs.onSurface.withAlpha(150),
              ),
            ),
          ],
        ),
        SizedBox(height: context.sp(8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: current / total),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            builder: (_, value, __) => LinearProgressIndicator(
              value: value,
              minHeight: context.sp(8),
              backgroundColor: cs.outline.withAlpha(50),
              color: cs.secondary,
            ),
          ),
        ),
      ],
    );
  }
}