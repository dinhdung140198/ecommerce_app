import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/categories.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/widgets/category_grib.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/categories';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _scafolldKey = GlobalKey<ScaffoldState>();
@override
  void didChangeDependencies() {
    Provider.of<Categories>(context,listen: false).fetchCategory();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
              onTap: () => Navigator.of(context).pushNamed(AccountScreen.routeName),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avartar!),
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
            CategoryGribWidget(),
          ],
        ),
      ),
    );
  }
}
