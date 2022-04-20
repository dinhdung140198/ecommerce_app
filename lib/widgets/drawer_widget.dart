import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth =Provider.of<Auth>(context);
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
              style: Theme.of(context).textTheme.subhead,
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
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'My Order',
              style: Theme.of(context).textTheme.subhead,
            ),
            trailing: Chip(
                label: Text(
              '8',
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Wish List',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
           ListTile(
            dense: true,
            title: Text(
              "Products",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Categories');
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Categories",
              style: Theme.of(context).textTheme.subhead,
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
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.body1,
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
              style: Theme.of(context).textTheme.subhead,
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
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Languages');
            },
            leading: Icon(
              UiIcons.planet_earth,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Languages",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              auth.logout();
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
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
