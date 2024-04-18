import 'package:flutter/material.dart';
import 'package:petty_shop_vinit/screens/history.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';
import 'package:petty_shop_vinit/widget/no_connection_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dog_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DogProvider>().calculateAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: colorBg,
        appBar: AppBar(
          backgroundColor: colorPrimary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: getTextWithStyle(context: context,text: "Cart", size: 24, color: Colors.white),
        ),
        body: provider.isConnected
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children:
                              List.generate(provider.dogs.length, (index) {
                        if (provider.dogs[index].isInCart == 1) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HistoryCard(
                              imageUrl: provider.dogs[index].message,
                              price: provider.dogs[index].price,
                              onTap: () {
                                provider.removeFromCart(provider.dogs[index]);
                              },
                              isAdded: provider.dogs[index].isInCart,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      })),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: const BoxDecoration(
                      color: colorPrimaryShade,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getTextWithStyle(
                          context: context,
                          text: "Total : ",
                          size: 20,
                          color: Colors.black,
                        ),
                        getTextWithStyle(
                          context: context,
                            text: "\$${provider.totalAmount}",
                            size: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
                ],
              )
            : const NoConnectionWidget(),
      );
    });
  }
}
