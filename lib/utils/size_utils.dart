import 'package:flutter/material.dart';

Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;
const num DESIGN_WIDTH = 390;
const num DESIGN_HEIGHT = 844;
const num DESIGN_STATUS_BAR = 112;

///This method is used to get device viewport width.
get width {
  return size.width;
}

///This method is used to get device viewport height.
get height {
  num statusBar =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;
  num screenHeight = size.height - statusBar;
  return screenHeight;
}

///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
double getHorizontalSize(BuildContext context,double px) {
  return (px * MediaQuery.of(context).size.width) / DESIGN_WIDTH;
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(BuildContext context,double px) {
  return (px * MediaQuery.of(context).size.height) / (DESIGN_HEIGHT - DESIGN_STATUS_BAR);
}

///This method is used to set smallest px in image height and width
double getSize(BuildContext context,double px) {
  var height = getVerticalSize(context,px);
  var width = getHorizontalSize(context,px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

///This method is used to set text font size according to Viewport
double getFontSize(BuildContext context,double px) {
  return getSize(context,px);
}

