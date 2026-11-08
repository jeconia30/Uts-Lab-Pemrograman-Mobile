import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.sp(16)),
    );
    final size = Size.fromHeight(context.sp(54));
    final textStyle = TextStyle(
      fontSize: context.sp(15),
      fontWeight: FontWeight.w600,
    );
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: context.sp(20)),
          SizedBox(width: context.sp(8)),
        ],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );

    if (outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: size,
          shape: shape,
          textStyle: textStyle,
        ),
        child: child,
      );
    }
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: size,
        shape: shape,
        textStyle: textStyle,
      ),
      child: child,
    );
  }
}