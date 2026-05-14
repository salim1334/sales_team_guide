import 'package:alarm_sales_guide/utils/constants/colors.dart';
import 'package:alarm_sales_guide/utils/constants/radii.dart';
import 'package:alarm_sales_guide/utils/constants/spacing.dart';
import 'package:alarm_sales_guide/utils/constants/typography.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────
// Color Schemes
// ─────────────────────────────────────────────────────────────────

final ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.secondaryContainer,
  onSecondaryContainer: AppColors.onSecondaryContainer,
  tertiary: AppColors.tertiary,
  onTertiary: AppColors.onTertiary,
  tertiaryContainer: AppColors.tertiaryContainer,
  onTertiaryContainer: AppColors.onTertiaryContainer,
  error: AppColors.error,
  onError: AppColors.onError,
  errorContainer: AppColors.errorContainer,
  onErrorContainer: AppColors.onErrorContainer,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  surfaceContainerHighest: AppColors.surfaceContainerHighest,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
  inverseSurface: AppColors.inverseSurface,
  onInverseSurface: AppColors.inverseOnSurface,
  inversePrimary: AppColors.inversePrimary,
  shadow: const Color(0x1A000000),
  scrim: AppColors.primary.withValues(alpha: 0.4),
);

const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // Primary becomes lighter, onPrimary dark
  primary: AppColors.primaryFixedDim,
  onPrimary: AppColors.primary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  // Secondary lighter
  secondary: AppColors.secondaryFixedDim,
  onSecondary: AppColors.onSecondaryFixed,
  secondaryContainer: AppColors.onSecondaryFixedVariant,
  onSecondaryContainer: AppColors.secondaryFixed,
  // Tertiary lighter
  tertiary: AppColors.tertiaryFixedDim,
  onTertiary: AppColors.onTertiaryFixed,
  tertiaryContainer: AppColors.tertiaryContainer,
  onTertiaryContainer: AppColors.onTertiaryContainer,
  // Error adapted for dark
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  // Surfaces – use dark overrides
  surface: AppColors.darkSurface,
  onSurface: AppColors.inverseOnSurface,
  surfaceContainerHighest: AppColors.darkSurfaceContainerHighest,
  onSurfaceVariant: AppColors.inverseOnSurface,
  outline: AppColors.outline,
  outlineVariant: AppColors.outlineVariant,
  inverseSurface: AppColors.surface,
  onInverseSurface: AppColors.onSurface,
  inversePrimary: AppColors.primary,
  shadow: Color(0x33000000),
  scrim: Colors.black54,
);

// ─────────────────────────────────────────────────────────────────
// Text Themes (light & dark)
// ─────────────────────────────────────────────────────────────────

TextTheme _buildTextTheme({required Color onSurface, required Color onSurfaceVariant}) {
  return TextTheme(
    displayLarge: AppTypography.displayLg.copyWith(color: onSurface),
    headlineMedium: AppTypography.headlineMd.copyWith(color: onSurface),
    headlineSmall: AppTypography.headlineSm.copyWith(color: onSurface),
    bodyLarge: AppTypography.bodyLg.copyWith(color: onSurface),
    bodyMedium: AppTypography.bodyMd.copyWith(color: onSurface),
    bodySmall: AppTypography.bodySm.copyWith(color: onSurfaceVariant),
    labelLarge: AppTypography.button.copyWith(color: onSurface),   // used as button style
    labelMedium: AppTypography.labelMd.copyWith(color: onSurface),
    labelSmall: AppTypography.labelMd.copyWith(color: onSurfaceVariant),
  );
}

// ─────────────────────────────────────────────────────────────────
// Public ThemeData accessors
// ─────────────────────────────────────────────────────────────────

abstract class AppTheme {
  /// Light theme – follows the exact design system.
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: _buildTextTheme(
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
      ),
      // Optional global defaults (kept minimal)
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.outlineVariant,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.onSecondaryContainer,
        unselectedItemColor: AppColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 1,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: AppColors.surfaceContainerLow,
        indicatorColor: AppColors.secondaryContainer,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.lg,
          side: const BorderSide(color: AppColors.outlineVariant),
        ),
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: AppRadii.defaultRadius,
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.defaultRadius,
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.defaultRadius,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
      ),
    );
  }

  /// Dark theme – adapted from the same palette for contrast & readability.
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: _buildTextTheme(
        onSurface: AppColors.inverseOnSurface,
        onSurfaceVariant: AppColors.inverseOnSurface,
      ),
      scaffoldBackgroundColor: AppColors.darkSurfaceContainerLowest,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurfaceContainerLowest,
        foregroundColor: AppColors.primaryFixedDim,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurfaceContainerLowest,
        selectedItemColor: AppColors.secondaryFixed,
        unselectedItemColor: AppColors.inverseOnSurface,
        type: BottomNavigationBarType.fixed,
        elevation: 1,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: AppColors.darkSurfaceContainerLowest,
        indicatorColor: AppColors.primaryContainer,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceContainerLowest,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.lg,
          side: const BorderSide(color: AppColors.outlineVariant),
        ),
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: AppRadii.defaultRadius,
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.defaultRadius,
          borderSide: const BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.defaultRadius,
          borderSide: const BorderSide(color: AppColors.primaryFixedDim, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
      ),
    );
  }
}