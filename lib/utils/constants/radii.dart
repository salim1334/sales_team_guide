import 'package:flutter/widgets.dart';

/// Border radius tokens matching the Design System.
abstract class AppRadii {
  /// 2 px – utility edges
  static const BorderRadius sm = BorderRadius.all(Radius.circular(2));

  /// 4 px – default for buttons, inputs…
  static const BorderRadius defaultRadius = BorderRadius.all(
    Radius.circular(4),
  );

  /// 6 px – md
  static const BorderRadius md = BorderRadius.all(Radius.circular(6));

  /// 8 px – large containers & cards
  static const BorderRadius lg = BorderRadius.all(Radius.circular(8));

  /// 12 px – xl
  static const BorderRadius xl = BorderRadius.all(Radius.circular(12));

  /// 9999 px – pill / full rounded
  static const BorderRadius full = BorderRadius.all(Radius.circular(9999));
}
