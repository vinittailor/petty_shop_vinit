import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_shop_vinit/provider/dog_provider.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';
import 'package:provider/provider.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProvider>(
        builder: (context, provider, child) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(noConnectionImg,height: 300,),
              GestureDetector(onTap: (){
                provider.fetchRandomDog(context);
              },child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    border: Border.all(color: colorPrimary),
                  ),
                  child: getTextWithStyle(context: context,text: "Retry", size: 20,fontWeight: FontWeight.w500))),
            ],
          ),
        );
      }
    );
  }
}