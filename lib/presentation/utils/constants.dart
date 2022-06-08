import 'package:flutter/material.dart';

const int screenSizeSmall = 640;
const int screenSizeMedium = 1008;

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= screenSizeSmall;
}
