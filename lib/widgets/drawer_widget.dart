import 'package:ecommerce_app/screens/categories.dart';
import 'package:ecommerce_app/screens/edit_product.dart';
import 'package:ecommerce_app/screens/favorite_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/orders.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {},
            child: UserAccountsDrawerHeader(
              accountEmail: Text('userEmail@hot.com'),
              accountName: Text('DinhDung',
                  style: Theme.of(context).textTheme.headline6),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(
                    'https://1.bp.blogspot.com/-wIaKEkcCTTk/XqjcK5-2a8I/AAAAAAAAk4k/opJSFhhMK2MXq51T3fXX8TaMUSW78alSgCEwYBhgL/s1600/hinh-nen-girl-xinh-4k-nu-cuoi-xinh-xan.jpg'),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1)),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              UiIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
            leading: Icon(
              UiIcons.inbox,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'My Order',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: Chip(
              label: Text(
                orders.orders.length.toString(),
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            },
            leading: Icon(
              UiIcons.heart,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Favorite List',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Products",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(CategoriesScreen.routeName);
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Categories",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Brands');
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Brands",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Help');
            },
            leading: Icon(
              UiIcons.information,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.settings_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            leading: Icon(
              UiIcons.planet_earth,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Manage Product",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
