import 'package:flutter/material.dart';

/// Defines a background color used in the app.
const Color colorBg = Color(0xffFBEDEC);

/// Defines the primary color used for buttons, accents, etc.
const Color colorPrimary = Color(0xff474672);


const Color colorPrimaryShade = Color(0xffCDC0F6);

/// Defines a secondary color used for text, icons, etc.
const Color colorSecondary  = Color(0xffC48590);

/// Defines a shade of the yellow color.
const Color colorYellow  = Color(0xffFFC315);

/// Defines a shade of the green color.
const Color colorSuccess  = Color(0xff22BB33);

/// Defines a shade of the red color.
const Color colorError  = Color(0xffbb2124);

Map<int, Color> color = {
  50: const Color.fromRGBO(71, 70, 114, .1),
  100: const Color.fromRGBO(71, 70, 114, .2),
  200: const Color.fromRGBO(71, 70, 114, .3),
  300: const Color.fromRGBO(71, 70, 114, .4),
  400: const Color.fromRGBO(71, 70, 114, .5),
  500: const Color.fromRGBO(71, 70, 114, .6),
  600: const Color.fromRGBO(71, 70, 114, 0.7),
  700: const Color.fromRGBO(71, 70, 114, .8),
  2090: const Color.fromRGBO(71, 70, 114, .9),
  900: const Color.fromRGBO(71, 70, 114, 1),
};

/// Creates a MaterialColor object representing a custom color palette.
///
/// A MaterialColor provides a range of shades for a single base color
/// (specified by `0xff474672` in this case).
///
/// The `color` map defines individual shades for different opacity levels
/// (e.g., 50 for 10% opacity, 100 for 20% opacity, and so on).
///
/// This allows you to use these colors consistently throughout your app
/// with different opacity levels (e.g., for highlighting, disabled elements, etc.).
MaterialColor colorCustom = MaterialColor(0xff474672, color);
