import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/route_generator.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/widgets/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/config/app_config.dart' as config;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Products())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        // onGenerateRoute: RouteGenerator.generatorRouter,
        routes: {
          CartScreen.routeName: (context) =>CartScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ProductDetailWidget.routeName: (context) => ProductDetailWidget(),
        },
        darkTheme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Color(0xFF252525),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFF2C2C2C),
            accentColor: config.Colors().mainDarkColor(1),
            hintColor: config.Colors().secondDarkColor(1),
            focusColor: config.Colors().accentDarkColor(1),
            textTheme: TextTheme(
              button: TextStyle(color: Color(0xFF252525)),
              caption: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
            )),
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          brightness: Brightness.light,
          accentColor: config.Colors().mainColor(1),
          focusColor: config.Colors().accentColor(1),
          hintColor: config.Colors().secondColor(1),
          textTheme: TextTheme(
            button: TextStyle(color: Colors.white),
            caption: TextStyle(
                fontSize: 12.0, color: config.Colors().secondColor(0.6)),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
