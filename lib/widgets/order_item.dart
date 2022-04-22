import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/widgets/order_item_product.dart';

class OrderItemWiget extends StatefulWidget {
  final OrderItem order;
  const OrderItemWiget(this.order);

  @override
  State<OrderItemWiget> createState() => _OrderItemWigetState();
}

class _OrderItemWigetState extends State<OrderItemWiget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount!.toStringAsFixed(2)}',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime!),
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: min(widget.order.products!.length * 100.0 + 10, 200),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.order.products!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return OrderItemProduct(
                      orderProduct: widget.order.products![index],
                    );
                  },
                ))
        ],
      ),
    );
  }
}
