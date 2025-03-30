import 'package:flutter/material.dart';
import 'package:product3/addPage.dart';
import 'package:product3/searchPage.dart';
import 'home.dart';

class ecommerce extends StatelessWidget {
  const ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ecommerce',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => const HomePage(),
          '/addProduct': (BuildContext context) => const AddProductPage(),
          'searchPage': (BuildContext context) => const ProductSearchApp(),
        });
  }
}
