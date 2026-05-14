import 'package:flutter/material.dart';

/// All color constants from the Design System.
/// Light mode uses the standard colors; Dark mode overrides selected roles.
abstract class AppColors {
  // ─── Surface / Background ─────────────────────────────────────
  static const Color background = Color(0xFFFBF9FA);
  static const Color onBackground = Color(0xFF1B1C1D);

  static const Color surface = Color(0xFFFBF9FA);
  static const Color surfaceBright = Color(0xFFFBF9FA);
  static const Color surfaceDim = Color(0xFFDBD9DB);

  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F3F4);
  static const Color surfaceContainer = Color(0xFFEFEDEF);
  static const Color surfaceContainerHigh = Color(0xFFE9E7E9);
  static const Color surfaceContainerHighest = Color(0xFFE4E2E3);

  static const Color onSurface = Color(0xFF1B1C1D);
  static const Color onSurfaceVariant = Color(0xFF44474C);

  static const Color inverseSurface = Color(0xFF303032);
  static const Color inverseOnSurface = Color(0xFFF2F0F2);

  static const Color surfaceTint = Color(0xFF4F6073);

  // ─── Primary ──────────────────────────────────────────────────
  static const Color primary = Color(0xFF041627);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF1A2B3C);
  static const Color onPrimaryContainer = Color(0xFF8192A7);
  static const Color inversePrimary = Color(0xFFB7C8DE);

  static const Color primaryFixed = Color(0xFFD2E4FB);
  static const Color primaryFixedDim = Color(0xFFB7C8DE);
  static const Color onPrimaryFixed = Color(0xFF0B1D2D);
  static const Color onPrimaryFixedVariant = Color(0xFF38485A);

  // ─── Secondary (Success / Emerald) ────────────────────────────
  static const Color secondary = Color(0xFF3B6934);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFB9EEAB);
  static const Color onSecondaryContainer = Color(0xFF3F6D38);

  static const Color secondaryFixed = Color(0xFFBCF0AE);
  static const Color secondaryFixedDim = Color(0xFFA1D494);
  static const Color onSecondaryFixed = Color(0xFF002201);
  static const Color onSecondaryFixedVariant = Color(0xFF23501E);

  // ─── Tertiary (Amber / Brown) ─────────────────────────────────
  static const Color tertiary = Color(0xFF211200);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF38260B);
  static const Color onTertiaryContainer = Color(0xFFA88C69);

  static const Color tertiaryFixed = Color(0xFFFEDDB5);
  static const Color tertiaryFixedDim = Color(0xFFE1C29B);
  static const Color onTertiaryFixed = Color(0xFF281802);
  static const Color onTertiaryFixedVariant = Color(0xFF584326);

  // ─── Error ────────────────────────────────────────────────────
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // ─── Outlines / Borders ───────────────────────────────────────
  static const Color outline = Color(0xFF74777D);
  static const Color outlineVariant = Color(0xFFC4C6CD);

  // ─── Dark‑mode surface overrides (not part of the light palette) ────
  // These are inferred to create a coherent dark hierarchy.
  static const Color darkSurface = Color(0xFF303032);
  static const Color darkSurfaceContainerHighest = Color(0xFF44474C);
  static const Color darkSurfaceContainerHigh = Color(0xFF3C3D40);
  static const Color darkSurfaceContainer = Color(0xFF343536);
  static const Color darkSurfaceContainerLow = Color(0xFF2C2D30);
  static const Color darkSurfaceContainerLowest = Color(0xFF1B1C1D);
}
