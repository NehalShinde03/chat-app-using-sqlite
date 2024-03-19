import 'dart:core';

import 'package:flutter/material.dart';

abstract class Spacing {
  static const double none = 0;
  static const double xSmall = 4;
  static const double small = 8;
  static const double xMedium = 10;
  static const double medium = 12;
  static const double normal = 16;
  static const double large = 20;
  static const double xLarge = 24;
  static const double xxLarge = 30;
  static const double xxxLarge = 40;
}

abstract class PaddingValue {
  static const EdgeInsetsDirectional zero = EdgeInsetsDirectional.zero;
  static const EdgeInsetsDirectional xSmall = EdgeInsetsDirectional.all(Spacing.xSmall);
  static const EdgeInsetsDirectional small = EdgeInsetsDirectional.all(Spacing.small);
  static const EdgeInsetsDirectional xMedium = EdgeInsetsDirectional.all(Spacing.xMedium);
  static const EdgeInsetsDirectional medium = EdgeInsetsDirectional.all(Spacing.medium);
  static const EdgeInsetsDirectional normal = EdgeInsetsDirectional.all(Spacing.normal);
  static const EdgeInsetsDirectional large = EdgeInsetsDirectional.all(Spacing.large);
  static const EdgeInsetsDirectional xLarge = EdgeInsetsDirectional.all(Spacing.xLarge);
  static const EdgeInsetsDirectional xxLarge = EdgeInsetsDirectional.all(Spacing.xxLarge);

  static const EdgeInsetsDirectional onlySE = EdgeInsetsDirectional.only(start: Spacing.xxLarge,end: Spacing.xxLarge);
  static const EdgeInsetsDirectional onlyTB = EdgeInsetsDirectional.only(start: Spacing.normal,end: Spacing.normal);
}

abstract class RadiusValue {
  static const double xSmall = 8;
  static const double small = 12;
  static const double medium = 14;
  static const double normal = 16;
  static const double large = 20;
  static const double xLarge = 24;
  static const double xxLarge = 40;
  static const double xxxLarge = 48;
}

abstract class ShapeRadius {
  static const Radius zero = Radius.zero;
  static const Radius xSmall = Radius.circular(RadiusValue.xSmall);
  static const Radius small = Radius.circular(RadiusValue.small);
  static const Radius medium = Radius.circular(RadiusValue.medium);
  static const Radius normal = Radius.circular(RadiusValue.normal);
  static const Radius large = Radius.circular(RadiusValue.large);
  static const Radius xLarge = Radius.circular(RadiusValue.xLarge);
  static const Radius xxLarge = Radius.circular(RadiusValue.xxLarge);
  static const Radius xxxLarge = Radius.circular(RadiusValue.xxxLarge);
}

abstract class ShapeBorderRadius {
  static const BorderRadius zero = BorderRadius.zero;
  static const BorderRadius xSmall = BorderRadius.all(ShapeRadius.xSmall);
  static const BorderRadius small = BorderRadius.all(ShapeRadius.small);
  static const BorderRadius medium = BorderRadius.all(ShapeRadius.medium);
  static const BorderRadius normal = BorderRadius.all(ShapeRadius.normal);
  static const BorderRadius large = BorderRadius.all(ShapeRadius.large);
  static const BorderRadius xLarge = BorderRadius.all(ShapeRadius.xLarge);
  static const BorderRadius xxLarge = BorderRadius.all(ShapeRadius.xxLarge);
}

abstract class TextSize {
  static const double largeHHeading = 28;
  static const double heading = 20;
  static const double appBarTitle = 18;
  static const double appBarSubTitle = 14;
  static const double title = 16;
  static const double subTitle = 14;
  static const double label = 14;
  static const double content = 12;
  static const double body = 10;
}

abstract class TextWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

