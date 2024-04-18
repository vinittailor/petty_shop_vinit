import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petty_shop_vinit/screens/cart.dart';
import 'package:petty_shop_vinit/screens/history.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';
import 'package:petty_shop_vinit/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../provider/dog_provider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProvider>(builder: (context, provider, child) {
      return Container(
        height: getVerticalSize(context, 260),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: colorYellow,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(topLeftBubble),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(powFoots),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                  child: SvgPicture.asset(
                logo,
                width: getHorizontalSize(context, 130),
              )),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(bottomRightBubble),
            ),
            Positioned(
                right: 30,
                bottom: 30,
                child: Image.asset(
                  dogsImage,
                  width: getHorizontalSize(context, 186),
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: notchSize(context), left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        nextPage(context, const HistoryPage());
                      },
                      child: SvgPicture.asset(history)),
                  InkWell(
                    onTap: () {
                      nextPage(context, const CartPage(),
                          transition: Transition.rightToLeft);
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(cartBtn),
                        Positioned(
                          bottom: -3,
                          left: -3,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: colorPrimary,
                            child: getTextWithStyle(
                                context: context,
                                text: provider.totalCartCount.toString(),
                                size: 10,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
