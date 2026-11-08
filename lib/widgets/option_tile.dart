import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.sp(16));

    return Padding(
      padding: EdgeInsets.only(bottom: context.sp(12)),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(context.sp(14)),
          decoration: BoxDecoration(
            color: selected ? cs.primary.withAlpha(28) : cs.surface,
            borderRadius: radius,
            border: Border.all(
              color: selected ? cs.primary : cs.outline.withAlpha(90),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: context.sp(34),
                height: context.sp(34),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? cs.primary : cs.outline.withAlpha(40),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w700,
                    color: selected ? cs.onPrimary : cs.onSurface,
                  ),
                ),
              ),
              SizedBox(width: context.sp(14)),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: context.sp(15),
                    height: 1.35,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}