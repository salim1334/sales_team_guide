import 'package:flutter/painting.dart';

/// Box shadows for different elevation levels.
abstract class AppShadows {
  /// Level 1 – Cards, sections
  static const BoxShadow level1 = BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
    color: Color(0x0D1A2B3C), // rgba(26,43,60,0.05)
  );

  static const BoxShadow level1Bottom = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 6,
    spreadRadius: 0,
    color: Color(0x081A2B3C), // rgba(26,43,60,0.03)
  );

  /// Combined level‑1 shadow list.
  static const List<BoxShadow> cardShadow = [level1, level1Bottom];

  /// Level 2 – Dropdowns, modals (slightly stronger).
  static const List<BoxShadow> modalShadow = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x141A2B3C), // ~8% opacity
    ),
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: -2,
      color: Color(0x0F1A2B3C),
    ),
  ];

  /// Level 3 – Toasts, global alerts.
  static const List<BoxShadow> toastShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x1A1A2B3C),
    ),
  ];
}