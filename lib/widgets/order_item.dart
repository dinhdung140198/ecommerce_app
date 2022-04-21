import 'dart:math';

import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/widgets/product_detail.dart';
// import '../providers/orders.dart' ;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemWiget extends StatefulWidget {
  final OrderItem order;
  const OrderItemWiget(this.order) ;

  @override
  State<OrderItemWiget> createState() => _OrderItemWigetState();
}

class _OrderItemWigetState extends State<OrderItemWiget> {
  var _expanded =false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount!.toStringAsFixed(2)}',style: TextStyle(color: Theme.of(context).hintColor),),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime!), style: TextStyle(color: Theme.of(context).hintColor),),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              color: Theme.of(context).hintColor,
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.order.products!.length * 20.0 + 10, 180),
              child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: widget.order.products!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return OrderItemProduct(widget.order.products![index]);
                          },
              )
            )
        ],
      ),
    );
  }
}

class OrderItemProduct extends StatelessWidget {
  final CartItem orderProduct;
  const OrderItemProduct( this.orderProduct );

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: (){
          // Navigator.of(context).pushNamed(ProductDetailWidget.routeName);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: orderProduct,
                // tag: widget.heroTag + widget.order.product.id,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(image: NetworkImage(orderProduct.urlImage!), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            orderProduct.name!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 10,children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    UiIcons.calendar,
                                    color: Theme.of(context).focusColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    orderProduct.id!,
                                    style: Theme.of(context).textTheme.body1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    UiIcons.line_chart,
                                    color: Theme.of(context).focusColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'RBR1234567Q',
                                    style: Theme.of(context).textTheme.body1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ],
//                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("\$$orderProduct.price!", style: Theme.of(context).textTheme.display1),
                        SizedBox(height: 6),
                        Chip(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                          label: Text(
                            'x ${orderProduct.quantity}',
                            style: TextStyle(color: Theme.of(context).focusColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}

 
                            