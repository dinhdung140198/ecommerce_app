// import 'package:ecommerce_app/screens/home.dart';
// import 'package:ecommerce_app/widgets/product_detail.dart';
// import 'package:flutter/material.dart';

// class RouteGenerator {
//   static Route<dynamic> generatorRouter(RouteSettings settings) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       case '/Home':
//         return MaterialPageRoute(builder: (_) => HomeScreen());
//       case '/ProductDetail':
//         return MaterialPageRoute(builder: (_) => ProductDetailWidget());
//       default:
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute() {
//     return MaterialPageRoute(builder: (_) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//         ),
//         body: Center(
//           child: Text('ERROR'),
//         ),
//       );
//     });
//   }
// }
