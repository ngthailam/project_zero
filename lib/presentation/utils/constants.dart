import 'package:flutter/material.dart';

const int screenSizeSmall = 640;
const int screenSizeMedium = 1280;

T getOnScreenSize<T>(
  BuildContext context, {
  required T small,
  required T medium,
  required T large,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

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
