import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petty_shop_vinit/provider/dog_provider.dart';
import 'package:petty_shop_vinit/screens/home_page.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<DogProvider>(
      create: (context) => DogProvider(),
      child: GetMaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorCustom),
          useMaterial3: true,
        ),
       home: const HomePage(),
       ),

    );
  }
}

