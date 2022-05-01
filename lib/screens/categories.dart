import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scafolldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartMount = Provider.of<Cart>(context).itemCount;
    return Scaffold(
      key: _scafolldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => _scafolldKey.currentState!.openDrawer(),
            icon: Icon(
              Icons.sort,
              color: Theme.of(context).hintColor,
            )),
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          ShoppingCartButton(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor,
              labelCount: cartMount),
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 12.5),
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://1.bp.blogspot.com/-wIaKEkcCTTk/XqjcK5-2a8I/AAAAAAAAk4k/opJSFhhMK2MXq51T3fXX8TaMUSW78alSgCEwYBhgL/s1600/hinh-nen-girl-xinh-4k-nu-cuoi-xinh-xan.jpg'),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SearchBarWidget(
                callback: '',
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
