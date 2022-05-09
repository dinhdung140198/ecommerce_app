import 'package:flutter/material.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).accentColor),
      child: Center(
        child: Text(
          'Ecommerce App',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .merge(TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }
}
