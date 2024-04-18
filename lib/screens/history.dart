import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';
import 'package:petty_shop_vinit/widget/no_connection_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dog_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DogProvider>().checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DogProvider>(builder: (context, provider, child) {
      return Scaffold(
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
          title:
              getTextWithStyle(context: context,text: "History", size: 24, color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  provider.clearHistory();
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ))
          ],
        ),
        body: provider.isConnected
            ? SingleChildScrollView(
                child: Column(
                    children: List.generate(
                  provider.dogs.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HistoryCard(
                      imageUrl: provider.dogs[index].message,
                      price: provider.dogs[index].price,
                      onTap: () {
                        if (provider.dogs[index].isInCart == 1) {
                          provider.removeFromCart(provider.dogs[index]);
                        } else {
                          provider.addToCart(context, provider.dogs[index]);
                        }
                      },
                      isAdded: provider.dogs[index].isInCart,
                    ),
                  ),
                )),
              )
            : const NoConnectionWidget(),
      );
    });
  }
}

class HistoryCard extends StatefulWidget {
  String imageUrl;
  String price;
  Function() onTap;
  int isAdded;

  HistoryCard({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.onTap,
    required this.isAdded,
  });

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  child: Image.network(
                    widget.imageUrl,
                    width: 200,
                    fit: BoxFit.cover,
                    height: 150,
                  )),
            ],
          ),
          Positioned(
              top: 10,
              right: 10,
              child: getTextWithStyle(context: context,text: "\$${widget.price}", size: 20)),
          Positioned(
            bottom: 10,
            right: 10,
            child: SizedBox(
              child: widget.isAdded == 1
                  ? GestureDetector(
                      onTap: widget.onTap,
                      child: const Icon(
                        Icons.delete_outline,
                        color: colorError,
                      ),
                    )
                  : InkWell(
                      onTap: widget.onTap,
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
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
