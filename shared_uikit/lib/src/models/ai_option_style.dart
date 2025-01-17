import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

class AIOptionsStyle extends BaseStyles {
  TextStyle? itemTextStyle;
  Color? itemsSeparatorColor;
  Color? itemBackgroundColor;

  AIOptionsStyle({
    this.itemTextStyle,
    this.itemsSeparatorColor,
    this.itemBackgroundColor,
    super.width,
    super.height,
    super.background,
    super.gradient,
    super.border,
    super.borderRadius,
  });

  /// Copies current `AISmartRepliesStyle` with some changes
  AIOptionsStyle copyWith({
    TextStyle? itemTextStyle,
    Color? itemsSeparatorColor,
    Color? itemBackgroundColor,
    double? width,
    double? height,
    Color? background,
    Gradient? gradient,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
  }) {
    return AIOptionsStyle(
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      itemsSeparatorColor: itemsSeparatorColor ?? this.itemsSeparatorColor,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      width: width ?? this.width,
      height: height ?? this.height,
      background: background ?? this.background,
      gradient: gradient ?? super.gradient,
      border: border ?? this.border,
      borderRadius: borderRadius ?? super.borderRadius,
    );
  }

  /// Merges current [AIOptionsStyle] with [other]
  AIOptionsStyle merge(AIOptionsStyle? other) {
    if (other == null) return this;
    return copyWith(
      itemTextStyle: other.itemTextStyle,
      itemsSeparatorColor: other.itemsSeparatorColor,
      itemBackgroundColor: other.itemBackgroundColor,
      width: other.width,
      height: other.height,
      background: other.background,
      gradient: other.gradient,
      border: other.border,
      borderRadius: other.borderRadius,
    );
  }
}
