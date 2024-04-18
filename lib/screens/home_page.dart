import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_shop_vinit/screens/header.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';
import 'package:petty_shop_vinit/widget/no_connection_widget.dart';
import 'package:petty_shop_vinit/widget/shimmer_card.dart';
import 'package:provider/provider.dart';

import '../provider/dog_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final dogProvider = DogProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DogProvider>().fetchRandomDog(context).then((value) {
      context.read<DogProvider>().calculateAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: Column(
        children: [
          const Header(),
          const SizedBox(
            height: 20,
          ),
          Consumer<DogProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const ShimmerCard();
              } else if (!provider.isConnected) {
                return const NoConnectionWidget();
              } else if (provider.dogs.isEmpty) {
                provider.fetchRandomDog(context);
                return const Center(child: Text('No Data Found'));
              } else {
                return DogCard(
                  imageUrl: provider.dogs.last.message,
                  price: provider.dogs.last.price,
                  onTap: () {

                    if(provider.dogs.last.isInCart == 1){
                      provider.removeFromCart(provider.dogs.last);
                    }else{
                      provider.addToCart(
                        context,
                        provider.dogs.last,
                      );
                    }

                  },
                  isAdded: provider.dogs.last.isInCart,
                );
              }
            },
          ),
          const Spacer(),
          Consumer<DogProvider>(builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  provider.fetchRandomDog(context);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(colorPrimaryShade)),
                child: getTextWithStyle(
                  context: context,
                    text: "Fetch new dog",
                    size: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
          })
        ],
      ),
    );
  }
}



class DogCard extends StatelessWidget {
  String imageUrl;
  String price;
  Function() onTap;
  int isAdded;

  DogCard({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.onTap,
    required this.isAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300.0,
                ),
                child: Image.network(imageUrl, width: double.infinity),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTextWithStyle(context: context,text: "\$$price", size: 20),
                isAdded == 1
                    ? GestureDetector(
                        onTap: onTap,
                        child: const Icon(
                          Icons.delete_outline,
                          color: colorError,
                        ),
                      )
                    : InkWell(
                        onTap: onTap,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: colorPrimary,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(cart),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
