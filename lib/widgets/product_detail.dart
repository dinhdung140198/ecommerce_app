import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({Key? key}) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      key: _scaffoldkey,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, -2)),
            ]),
        child: Row(children: [
          Expanded(
              child: FlatButton(
            onPressed: () {},
            child: Icon(UiIcons.heart, color: Theme.of(context).primaryColor),
            padding: EdgeInsets.symmetric(vertical: 14),
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
          )),
          SizedBox(
            width: 10,
          ),
          FlatButton(
              onPressed: () {},
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Add to Cart',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).primaryColor,
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                    Text(
                      '2',
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme.of(context).primaryColor,
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                  ],
                ),
              ))
        ]),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                UiIcons.return_icon,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    UiIcons.shopping_cart,
                    color: Theme.of(context).hintColor,
                  )),
              Container(
                width: 30,
                height: 30,
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://1.bp.blogspot.com/-wIaKEkcCTTk/XqjcK5-2a8I/AAAAAAAAk4k/opJSFhhMK2MXq51T3fXX8TaMUSW78alSgCEwYBhgL/s1600/hinh-nen-girl-xinh-4k-nu-cuoi-xinh-xan.jpg'),
                  ),
                ),
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              )
            ],
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 350.0,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Hero(
                  tag: productId,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(loadProduct.urlImage!)),
                          )),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Theme.of(context).primaryColor,
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0),
                              Theme.of(context).scaffoldBackgroundColor
                            ],
                                stops: [
                              0,
                              0.4,
                              0.6,
                              1
                            ])),
                      ),
                    ],
                  )),
            ),
            bottom: TabBar(
              tabs: [],
            ),
          ),
          SliverList(delegate: SliverChildDelegate([]))
        ],
      ),
    );
  }
}
