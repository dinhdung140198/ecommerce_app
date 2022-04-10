import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/widgets/product_grib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Products>(context).fetchAndSendProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
            ),
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://toppng.com/uploads/preview/vu-thi-ha-user-pro-icon-115534024853ae3gswzwd.png',
                ),
                // child: Image.network(
                //   'https://toppng.com/uploads/preview/vu-thi-ha-user-pro-icon-115534024853ae3gswzwd.png',
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          )
        ],
      ),
      body: ProductGrid(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(UiIcons.bell),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.user_1),
            title: new Container(height: 0.0),
          ),
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
            title: new Container(height: 5.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.chat),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.heart),
            title: new Container(height: 0.0),
          )
        ],
      ),
    );
  }
}
