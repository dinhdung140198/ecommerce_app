import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/categories.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/providers/select_color.dart';
import 'package:ecommerce_app/providers/select_size.dart';
import 'package:ecommerce_app/providers/sliders.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/screens/auth.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/categories.dart';
import 'package:ecommerce_app/screens/category_products.dart';
import 'package:ecommerce_app/screens/checkout.dart';
import 'package:ecommerce_app/screens/checkout_done.dart';
import 'package:ecommerce_app/screens/favorite_list.dart';
import 'package:ecommerce_app/screens/flash.dart';
import 'package:ecommerce_app/screens/orders.dart';
import 'package:ecommerce_app/widgets/product_detail.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/config/app_config.dart' as config;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: SelectSize()),
          ChangeNotifierProvider.value(value: SelectColor()),
          ChangeNotifierProvider.value(value: Categories()),
          ChangeNotifierProvider.value(value: SliderList()),
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProxyProvider<Auth, Products>(create: (_) {
            return Products('', '', []);
          }, update: (ctx, auth, previousProducts) {
            return Products(auth.token, auth.userId,
                previousProducts == null ? [] : previousProducts.items);
          }),
          ChangeNotifierProxyProvider<Auth, Orders>(create: (_) {
            return Orders('', '', []);
          }, update: (ctx, auth, previousOrders) {
            return Orders(auth.token, auth.userId,
                previousOrders == null ? [] : previousOrders.orders);
          }),
          ChangeNotifierProxyProvider<Auth, UserProvider>(
            create: (_) {
              return UserProvider(
                '',
                '',
                // UserModel.init()
                UserModel.advanced(
                  id: '',
                  name: '',
                  email: '',
                  avartar: '',
                  gender: '',
                  address: '',
                  dateOfBirth: DateTime.now(),
                ),
              );
            },
            update: (ctx, auth, previousUser) {
              return UserProvider(
                  auth.token,
                  auth.userId,
                  previousUser == null
                      ? 
                      // UserModel.init()
                      UserModel.advanced(
                          id: '',
                          name: '',
                          email: '',
                          avartar: '',
                          gender: '',
                          address: '',
                          dateOfBirth: DateTime.now(),
                        )
                      : previousUser.user);
            },
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ecommerce App',
            initialRoute: '/',
            routes: {
              AccountScreen.routeName: (context) => AccountScreen(),
              CategoryProductsScreen.routeName: (context) =>
                  CategoryProductsScreen(),
              CategoriesScreen.routeName: (context) => CategoriesScreen(),
              FavoriteScreen.routeName: (context) => FavoriteScreen(),
              AuthScreen.routeName: (context) => AuthScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              CheckoutDoneScreen.routeName: (context) => CheckoutDoneScreen(),
              CheckoutScreen.routeName: (context) => CheckoutScreen(),
              CartScreen.routeName: (context) => CartScreen(),
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
                      fontSize: 12.0,
                      color: config.Colors().secondDarkColor(0.7)),
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
            home: auth.isAuth
                ? HomeScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? FlashScreen()
                            : AuthScreen()),
          ),
        ));
  }
}
