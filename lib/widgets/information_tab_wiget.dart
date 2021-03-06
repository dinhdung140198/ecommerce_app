import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/select_color.dart';
import 'package:ecommerce_app/widgets/rating_bar.dart';
import 'package:ecommerce_app/widgets/select_color.dart';
import 'package:ecommerce_app/widgets/selected_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformationTabWiget extends StatefulWidget {
  final Product? product;
  const InformationTabWiget({Key? key, @required this.product})
      : super(key: key);

  @override
  State<InformationTabWiget> createState() => _InformationTabWigetState();
}

class _InformationTabWigetState extends State<InformationTabWiget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                widget.product!.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline3,
              )),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => RatingBarWidget(
                            product: widget.product,
                            flag: 'product',
                          ));
                  setState(() {});
                },
                child: Chip(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product!.rate!.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                            TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                      Icon(
                        Icons.star_border,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(0),
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.9),
                  shape: StadiumBorder(),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$${widget.product!.price!.toString()}",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "\$${(widget.product!.price! + 5).toStringAsFixed(2).toString()}",
                style: Theme.of(context).textTheme.headline5!.merge(TextStyle(
                    color: Theme.of(context).focusColor,
                    decoration: TextDecoration.lineThrough)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '450 Sales',
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.15),
                    blurRadius: 5,
                    offset: Offset(0, 2))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Select Color',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ],
              ),
              SizedBox(height: 10),
              SelectColorWidget(colors: widget.product!.colors),
              
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Select Size',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SelectSizeWidget(sizes: widget.product!.sizes)
            ],
          ),
        ),
      ],
    );
  }
}
