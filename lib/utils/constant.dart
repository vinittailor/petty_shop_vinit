
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petty_shop_vinit/utils/size_utils.dart';

import 'colors.dart';

//region Assets path
const String logo = "assets/images/logo.svg";


const String topLeftBubble = "assets/images/top_left_bubble.svg";
const String bottomRightBubble = "assets/images/bottom_right_bubble.svg";
const String powFoots = "assets/images/pow_foots.svg";
const String dogsImage = "assets/images/dogs_image.png";
const String cartBtn = "assets/images/cart_btn.svg";
const String history = "assets/images/history.svg";
const String cart = "assets/images/cart.svg";
const String noConnectionImg = "assets/images/no_connection.svg";


//endregion

const String appName = "Petty Shop";



//region Widget
Text getTextWithStyle({
  /// The text content to be displayed.
  required BuildContext context,

  required String text,

  /// The desired font size.
  required double size,

  /// The text color (defaults to the black color).
  Color color = Colors.black,

  /// The text weight (defaults to normal).
  FontWeight fontWeight = FontWeight.normal,

  /// The text alignment (defaults to left-aligned).
  TextAlign textAlign = TextAlign.left,
}) =>
    Text(
      text,
      style:  TextStyle(
          fontSize: getHorizontalSize(context,size),
          color: color,
          fontWeight: fontWeight,
        ),
      textAlign: textAlign,
    );
//endregion


void showSnackBar(context, String message, color, [int duration = 2000]) {
  try {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  } catch (e) {
    if (kDebugMode) {
      print("SnackBar Error :: $e");
    }
  }
  final snackBar = SnackBar(
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(12),
    backgroundColor: color,
    duration: Duration(milliseconds: duration),

    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

double notchSize(BuildContext context) {
  ///this code is identify device has notch or not also notch height
  if (MediaQuery.of(context).viewPadding.top == 0) {
    return 20;
  } else {
    return MediaQuery.of(context).viewPadding.top + 10;
  }
}

//region Routing
Future? nextPage(context, Widget page,{Transition transition = Transition.leftToRight}) {
  return Get.to(page, transition: transition);
}

replacePage(context, Widget page) {
  return Get.off(page, transition: Transition.leftToRight);
}

replaceAllPage(context, Widget page) {
  return Get.offAll(page, transition: Transition.leftToRight);
}
//endregion
