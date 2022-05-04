import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/favorite_list.dart';
import 'package:ecommerce_app/screens/orders.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartCount = Provider.of<Cart>(context).itemCount;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldState.currentState!.openDrawer();
          },
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
        ),
        title: Text(
          'Account',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          ShoppingCartButton(
            iconColor: Theme.of(context).hintColor,
            labelColor: Theme.of(context).accentColor,
            labelCount: cartCount,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, right: 12.5, bottom: 12.5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(''),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SearchBarWidget(callback: 'callback')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name user',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        'email',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(300)),
                    child: CircleAvatar(backgroundImage: NetworkImage('Image')),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoriteScreen.routeName),
                      child: Column(
                        children: [
                          Icon(UiIcons.heart),
                          Text(
                            'Favorite List',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoriteScreen.routeName),
                      child: Column(
                        children: [
                          Icon(UiIcons.favorites),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoriteScreen.routeName),
                      child: Column(
                        children: [
                          Icon(UiIcons.chat_1),
                          Text(
                            'Message',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  ListTile(
                    leading: Icon(UiIcons.inbox),
                    title: Text(
                      'My Orders',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: FlatButton(
                        child: Text(
                          'View all',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(OrdersScreen.routeName),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.of(context).pushNamed(OrdersScreen.routeName),
                    dense: true,
                    title: Text(
                      'Unpaid',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        '1',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Orders');
                    },
                    dense: true,
                    title: Text(
                      'To be shipped',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        '5',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Orders');
                    },
                    dense: true,
                    title: Text(
                      'Shipped',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        '3',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Orders');
                    },
                    dense: true,
                    title: Text(
                      'In dispute',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  ListTile(
                    leading: Icon(UiIcons.user_1),
                    title: Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: ButtonTheme(padding:EdgeInsets.all(0),minWidth: 50.0,height: 25.0,child: , ),
                  ),
                  ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Full name',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    _user.name,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    _user.email,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Gender',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    _user.gender,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Birth Date',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    _user.getDateOfBirth(),
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ],
              ),
            ),
            Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: Icon(UiIcons.settings_1),
                  title: Text(
                    'Account Settings',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      Icon(
                        UiIcons.placeholder,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Shipping Adresses',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Languages');
                  },
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      Icon(
                        UiIcons.planet_earth,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Languages',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  trailing: Text(
                    'English',
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Help');
                  },
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      Icon(
                        UiIcons.information,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Help & Support',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
