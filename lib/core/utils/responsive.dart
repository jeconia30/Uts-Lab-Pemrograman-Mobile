import 'dart:math';
import 'package:flutter/material.dart';

/// Lebar maksimum konten supaya tetap proporsional di tablet / web.
const double maxContentWidth = 600;

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Lebar konten sebenarnya (dibatasi untuk layar lebar).
  double get contentWidth => min(screenSize.width, maxContentWidth);

  /// Skala ukuran berdasarkan lebar layar (basis desain 390).
  double sp(double value) => value * (contentWidth / 390).clamp(0.85, 1.3);
}