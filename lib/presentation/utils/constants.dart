import 'package:flutter/material.dart';

const int screenSizeSmall = 640;
const int screenSizeMedium = 1280;
const int screenSizeLarge = 1600;

T getOnScreenSize<T>(
  BuildContext context, {
  required T small,
  required T medium,
  required T large,
  T? huge,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth > screenSizeLarge) {
    return huge ?? large;
  }
  if (screenWidth > screenSizeMedium) return large;
  if (screenWidth > screenSizeSmall) return medium;

  return small;
}

Widget buildOnScreenSize(
  BuildContext context, {
  required Widget small,
  required Widget medium,
  required Widget large,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth > screenSizeMedium) return large;
  if (screenWidth > screenSizeSmall) return medium;

  return small;
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= screenSizeSmall;
}
