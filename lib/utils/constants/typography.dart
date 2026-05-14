import 'package:flutter/material.dart';

/// Raw text styles (without colour) that follow the Design System.
/// Apply a colour via `copyWith(color: ...)` when building a ThemeData.
abstract class AppTypography {
  static const String _fontFamily = 'Inter';

  // ── Display ───────────────────────────────────────────────────
  static const TextStyle displayLg = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32, // 1.25
    letterSpacing: -0.64, // -0.02em * 32px
  );

  // ── Headline ──────────────────────────────────────────────────
  static const TextStyle headlineMd = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24, // ~1.333
    letterSpacing: -0.24, // -0.01em * 24px
  );

  static const TextStyle headlineSm = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20, // 1.4
  );

  // ── Body ──────────────────────────────────────────────────────
  static const TextStyle bodyLg = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16, // 1.5
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14, // ~1.428
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12, // ~1.333
  );

  // ── Label & Button ────────────────────────────────────────────
  static const TextStyle labelMd = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12, // ~1.333
    letterSpacing: 0.6, // 0.05em * 12px
  );

  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14, // ~1.428
  );
}
