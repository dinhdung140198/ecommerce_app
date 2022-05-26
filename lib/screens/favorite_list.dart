import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/screens/categories.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/product_grib.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = '/favorite';

  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String valSearch = '';
  void _selectedTab(int tabItem) {
    setState(() {
      switch (tabItem) {
        case 0:
          Navigator.of(context).pushNamed('/');
          break;
        case 1:
          Navigator.of(context).pushNamed(AccountScreen.routeName);
          break;
        case 2:
          Navigator.of(context).pushNamed(HomeScreen.routeName);
          break;
        case 3:
          Navigator.of(context).pushNamed(CategoriesScreen.routeName);
          break;
        case 4:
          Navigator.of(context).pushNamed(FavoriteScreen.routeName);
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    void onChangedSearch(value) {
      if (value != null) {
        setState(() {
          valSearch = value;
        });
      }
    }

    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      key: _scafoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Favorite',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => _scafoldKey.currentState!.openDrawer(),
          color: Theme.of(context).hintColor,
        ),
        actions: [
          ShoppingCartButton(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor,
              labelCount: cart.itemCount),
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(AccountScreen.routeName),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user!.avartar!),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
            child: SearchBarWidget(callback: (val) => onChangedSearch(val)),
          ),
          ProductGrid(isFavor: true, value: valSearch),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Colors.transparent,
        iconSize: 22,
        elevation: 0,
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        onTap: (int i)=> _selectedTab(i),
        items: [
          BottomNavigationBarItem(icon: Icon(UiIcons.bell), label: 'Notif'),
          BottomNavigationBarItem(icon: Icon(UiIcons.user_1), label: 'Account'),
          BottomNavigationBarItem(
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 40,
                          offset: Offset(0, 15)),
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 13,
                          offset: Offset(0, 3))
                    ]),
                child: Icon(
                  UiIcons.home,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(UiIcons.folder_1), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(UiIcons.heart), label: 'Favorite')
        ],
      ),
    );
  }
}
